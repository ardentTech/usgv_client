import { UsMapLegend } from "./us_map_legend.js";
import MessageBus from "../message_bus.js";

const SELECTED_STATE_COLOR = "#08306b";
const TRANSITION_DURATION = 750;


// @todo find a better way to orchestrate what loads when than all these checks+timeouts


export class UsMap {

    constructor(parentId) {
        this.color = d3.scaleSequential(d3.interpolateReds);
        this.legend = new UsMapLegend(160);
        this.parentId = parentId;
        this.path = d3.geoPath();
        this.selectedState = null;
        this.svg = null;
        this.rendered = false;
        this.statesData = {};

        d3.select(window).on("resize", () => this.resize());
    }

    colorFor(d) { return this.color(this.statesData[d.id].value); }

    highlightState(d) {
        d3.select(".state.active")
            .attr("class", "state")
            .transition()
            .duration(TRANSITION_DURATION)
            .style("fill", (d0) => this.colorFor(d0));

        if (typeof d !== "undefined") {
            d3.select(d)
                .attr("class", "state active")
                .transition()
                .duration(TRANSITION_DURATION)
                .style("fill", SELECTED_STATE_COLOR);
        }
    }

    onStateClick(d, i, nodes) {
        this.selectedState = d.id;
        this.highlightState(nodes[i]);
        this.legend.updateIndicator(this.statesData[d.id].value);
        MessageBus.broadcast("state:clicked", d.id);
    }

    onStateSelect(fips) {
        if (this.rendered && this.color.domain()[1] != 1) {
            this.selectedState = fips;
            if (fips !== null) {
                this.highlightState("#state-" + fips);
                this.legend.updateIndicator(this.statesData[fips].value);
            } else {
                this.highlightState(null);
                this.legend.updateIndicator(null);
            }
        } else {
            setTimeout(() => this.onStateSelect(fips), 25);
        }
    }

    // @todo appears to get called twice...
    onStatesReady(states) {
        states.forEach((s) => {
            this.statesData[s.fips_code] = {
                "name": s.name, "postal_code": s.postal_code, "value": 0 };
        });
        if (this.rendered) {
            d3.selectAll(".state")
                .append("svg:title")
                .text((d) => this.statesData[d.id].name);
        } else {
            setTimeout(() => this.onStatesReady(states), 25);
        }
    }

    render(topoData) {
        if (document.getElementById(this.parentId) !== null) {
            this.svg = d3.select("svg").attr("width", "100%");
            this.statesBg = this.svg.append("svg:rect")
                .attr("width", "100%")
                .style("fill", "#fff")
                .on("click", () => {
                    this.selectedState = null;
                    this.highlightState();
                    this.legend.updateIndicator(null);
                    MessageBus.broadcast("state:clicked", null)
                });
            this.renderStates(topoData);
            this.legend.renderTo(this.svg);
            this.rendered = true;
            this.resize();
        } else {
            setTimeout(() => this.render(topoData), 25);
        }
    }

    renderStates(topoData) {
        this.svg.append("svg:g")
            .attr("class", "states")
            .selectAll(".state")
            .data(topojson.feature(topoData.raw, topoData.states).features)
            .enter().append("svg:path")
                .attr("d", this.path)
                .attr("class", "state")
                // 05 is valid in HTML but not CSS3 querySelector
                .attr("id", (d) => "state-" + d.id)
                .on("click", (d, i, nodes) => this.onStateClick(d, i, nodes))
                .style("fill", (d) => this.color(0));

        this.svg.append("svg:path")
            .attr("id", "state-borders")
            .attr("d", this.path(topojson.mesh(
                topoData.raw, topoData.states, (a, b) => a !== b)));
    }

    resize() {
        if (!this.rendered) return;

        let width = this.width(),
            height = null;

        if (width > 992) {
            height = width * 0.62;
        } else if (width > 400) {
            height = width * 0.70;
        } else {
            height = width * 0.75;
        }

        this.svg.attr("height", height);
        this.statesBg.attr("height", height);

        d3.select("g.states").attr("transform", "scale(" + (width / 1000) + ")");
        d3.select("path#state-borders").attr("transform", "scale(" + (width / 1000) + ")");

        this.legend.resize(this.svg);
    }

    titleText(metric, d) {
        let state = this.statesData[d.id];

        if (metric.charAt(metric.length - 1) === "s") {
            if (state.value === 1) metric = metric.slice(0, -1);
        }

        return state.name + ": " + state.value + " " +
            metric.toLowerCase();
    }

    // @todo this gets `fips` while onStatesReady gets `fips_code`
    update(stats) {
        if (this.rendered) {
            let max = d3.max(stats.results, (d) => d.value);
            this.color.domain([0, max]);
            this.legend.update(this.color);
            this.updateStates(stats);
        } else {
            setTimeout(() => this.update(stats), 25);
        }
    }

    updateStates(data) {
        for (let [k, v] of Object.entries(this.statesData)) {
            let item = data.results.filter((d) => d.fips == k)[0];
            this.statesData[k].value = typeof item === "undefined" ? 0 : item.value;
        }

        d3.selectAll(".state")
            .transition()
            .duration(TRANSITION_DURATION)
            .style("fill", (d) => d.id === this.selectedState ? SELECTED_STATE_COLOR : this.colorFor(d));

        d3.selectAll(".state")
            .select("title")
            .text((d) => this.titleText(data.metric, d));
    }

    // @todo accept elem or id to get width of
    width() { return document.getElementById(this.parentId).clientWidth; }
}
