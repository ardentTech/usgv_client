export class LinearGradient {

    constructor(settings) {
        this.height = settings.height;
        this.width = settings.width;
    }

    renderTo(root) {
        this.gradient = root.append("defs")
            .append("svg:linearGradient")
            .attr("id", "linear-gradient")
            .attr("x1", "0%")
            .attr("y1", "100%")
            .attr("x2", "100%")
            .attr("y2", "100%")
            .attr("spreadMethod", "pad");

        this.rect = root.append("rect")
            .attr("width", this.width)
            .attr("height", this.height)
            .style("fill", "url(#linear-gradient)")
            .attr("transform", "translate(0,0)");
    }

    update(data) {
        let stops = this.gradient.selectAll(".stop")
            .data(data);

        stops.attr("offset", (d, i) => (i * 100 / (data.length - 1)) + "%")
            .attr("stop-color", (d) => d)

        stops.enter().append("stop")
            .attr("offset", (d, i) => (i * 100 / (data.length - 1)) + "%")
            .attr("stop-color", (d) => d) 
            .attr("stop-opacity", 1);
    }
}
