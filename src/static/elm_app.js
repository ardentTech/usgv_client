import * as Elm from "../elm/Main";
import MessageBus from "./message_bus.js";


class ElmApp {

    constructor() {
        this.app = Elm.Main.embed(
            document.getElementById("main"), { docRoot: process.env.DOC_ROOT });
        this.messageBus = MessageBus;
    }

    // @todo should use message bus
    send(key, value) { this.app.ports[key].send(value); }

    // @todo should use message bus
    receive(key, callback) { this.app.ports[key].subscribe(callback); }
}


export default new ElmApp();
