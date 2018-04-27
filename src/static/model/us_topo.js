class UsTopo {

    constructor() {
        this.formatter = d3.json;
        this.path = "static/data/us-10m.v1.json";
    }

    get states() { return this.raw.objects.states; }

    load(callback) {
        d3.queue().defer(this.formatter, this.path).await((error, data) => {
            if (error) throw error;
            this.raw = data;
            callback(this);
        });
    }
}


export default new UsTopo();
