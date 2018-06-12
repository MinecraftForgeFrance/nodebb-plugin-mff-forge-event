const jsonfile = require("jsonfile");
const plugin = {};

plugin.init = (params, callback) => {
    let app = params.router;
    let middleware = params.middleware;

    app.get("/forgeevents", middleware.buildHeader, renderForgeEvent);
    app.get("/api/forgeevents", renderForgeEvent);
    callback();
};

plugin.addNavigation = (menu, callback) => {
    menu = menu.concat([
        {
            route: "/forgeevents",
            title: "Forge Events",
            iconClass: "fa-code-fork",
            textClass: "visible-xs-inline",
            text: "Forge Events"
        }
    ]);

    callback(null, menu);
};

function renderForgeEvent(req, res) {
    let eventList = jsonfile.readFileSync("forge_events.json");
    let event = [];
    for (let keys of Object.keys(eventList)) {
        eventList[keys].formated_name = eventList[keys].simple_name.replace(/([a-z])([A-Z])/g, '$1-$2').replace(/\./g, '-').toLowerCase();
        if (JSON.stringify(eventList[keys].sides) === JSON.stringify(["client", "server"])) {
            eventList[keys].sides = ["common"];
        }

        if (typeof (eventList[keys].children) !== "undefined") {
            let childArray = [];
            console.log(eventList[keys]);
            for (let child of eventList[keys].children) {
                childArray.push({
                    full_name: child,
                    formated_name: eventList[child].simple_name.replace(/([a-z])([A-Z])/g, '$1-$2').replace(/\./g, '-').toLowerCase()
                });
                console.log(eventList[child]);
            }
            eventList[keys].children = childArray;
            console.log(eventList[keys]);
        }
        event.push(eventList[keys]);
    }
    //console.log(event);
    res.render("client/plugins/forge-event", {event});
}

module.exports = plugin;
