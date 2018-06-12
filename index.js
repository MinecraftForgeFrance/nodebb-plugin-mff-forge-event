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
    let eventList = jsonfile.readFileSync(__dirname + "/forge_events.json");
    let event = [];

    // Format event name to suitable anchor name
    for(let key of Object.keys(eventList)) {
        eventList[key].anchor = eventList[key].simple_name.replace(/([a-z])([A-Z])/g, '$1-$2').replace(/\./g, '-').toLowerCase();
    }

    for (let key of Object.keys(eventList)) {
        if (JSON.stringify(eventList[key].sides) === JSON.stringify(["client", "server"])) {
            eventList[key].sides = ["common"];
        }

        if (typeof (eventList[eventList[key].inherit]) !== "undefined") {
            eventList[key].inherit = {
                anchor: eventList[eventList[key].inherit].anchor,
                name: eventList[eventList[key].inherit].simple_name
            };
        } else {
            delete eventList[key].inherit;
        }

        if (typeof (eventList[key].children) !== "undefined") {
            let childArray = [];
            for (let child of eventList[key].children) {
                childArray.push({
                    name: eventList[child].simple_name,
                    anchor: eventList[child].anchor
                });
            }
            eventList[key].children = childArray;
        }
        event.push(eventList[key]);
    }
    //console.log(event);
    res.render("client/plugins/forge-event", {event});
}

module.exports = plugin;
