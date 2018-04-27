require("./styles/main.scss");

import ElmApp from "./elm_app.js";
import MessageBus from "./message_bus.js";
import { UsMap } from "./view/us_map.js";
import UsTopo from "./model/us_topo.js";


class App {
    constructor() {
        // @todo should only load on "/" URI path
        this.usMap = new UsMap("vis");
        console.log(this.upMap);

        ElmApp.receive("stateStatsUpdated", (data) => this.usMap.update(data));
        ElmApp.receive("stateSelected", (data) => this.usMap.onStateSelect(data));
        ElmApp.receive("statesReady", (data) => this.usMap.onStatesReady(data));
    }

    main() {
        UsTopo.load((model) => this.usMap.render(model));

        // @todo elm app should listen to this
        MessageBus.subscribe("state:clicked", "elm-app", (data) => ElmApp.send("stateClicked", data));
    }
}


new App().main();
