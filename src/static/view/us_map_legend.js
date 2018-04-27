import { LinearGradient } from "./linear_gradient.js";


// @todo transition duration on init
export class UsMapLegend {

    constructor(width) {
        this.gradient = new LinearGradient({height: 15, width: width});
        this.indicator = null;
        this.root = null;
        this.width = width;
        this.xScale = d3.scaleLinear();
        this.xAxis = d3.axisBottom()
            .scale(this.xScale)
            .ticks(7);
    }

    renderTo(elem) {
        this.root = elem.append("svg:g")
            .attr("class", "legend")
        this.gradient.renderTo(this.root);
        this.ticks = this.root.append("g")
            .attr("class", "x axis")
            .attr("transform", "translate(0, 15)")
        this.indicator = this.root.append("svg:line")
            .attr("id", "indicator");
    }

    resize(elem) {
        let width = elem.node().clientWidth || (
                elem.node().parentNode.clientWidth - 32),
            height = elem.node().clientHeight || (
                elem.node().parentNode.clientHeight - 5);

        this.root.attr(
            "transform", "translate(" + (width - (this.width + 7)) + "," + (height - 34) + ")");
    }

    update(colorScale) {
        this.gradient.update(
            Array(colorScale.domain()[1] + 1).fill().map((d, i) => colorScale(i)));
        this.xScale.domain(colorScale.domain()).range([0, this.width]);
        this.ticks
            .transition()
            .duration(500)
            .call(this.xAxis);
    }

    updateIndicator(val) {
        if (val !== null) {
            this.indicator
                .style("opacity", 100)
                .transition()
                .duration(500)
                .attr("x1", this.xScale(val))
                .attr("y1", 0)
                .attr("x2", this.xScale(val))
                .attr("y2", 20);
        } else {
            this.indicator
                .transition()
                .duration(500)
                .style("opacity", 0);
        } 
    } 
}
