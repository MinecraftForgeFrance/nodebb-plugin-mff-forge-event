const jsonfile = require("jsonfile");
const plugin = {};

plugin.init = (params, callback) => {
    let app = params.router;
    let middleware = params.middleware;

    app.get("/forgeevents", middleware.buildHeader, renderForgeEvent);
    app.get("/discordapi/forgeevents", getForgeEvent);
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
    let events = parseForgeEventJson();
    let searchValue = req.query.search === undefined ? "" : req.query.search;
    res.render("client/plugins/forge-event", {event: events, searchValue: searchValue});
}

function getForgeEvent(req, res) {
    return searchForgeEvent(req, res, parseForgeEventJson());
}

function searchForgeEvent(req, res, events) {
    let eventResult = {};
    let eventName = req.query.term;
    if (typeof (eventName) !== "undefined") {
        for (let event of events) {
            let regEventName = new RegExp(eventName, 'i');
            if (event.simple_name.match(regEventName)) {
                eventResult[event.simple_name] = {
                    package: event.package,
                    description: event.description,
                    anchors: event.anchor
                };
            }
        }
        if (eventResult.length === 0) {
            return res.status(200).send({message: "No result"});
        }
    }
    else {
        return res.status(400).json({error: "Missing arguments"})
    }

    return res.status(200).json(eventResult);
}

function parseForgeEventJson() {
    let eventList = jsonfile.readFileSync(__dirname + "/forge_events.json");
    let events = [];

    // Format event name to suitable anchor name
    for (let key of Object.keys(eventList)) {
        eventList[key].anchor = eventList[key].simple_name.replace(/([a-z])([A-Z])/g, '$1-$2').replace(/\./g, '-').toLowerCase();
    }

    for (let key of Object.keys(eventList)) {
        // Is the event annotated ?
        eventList[key].annotated = eventList[key].has_result || eventList[key].cancelable;

        // Search parent class in the json file
        if (typeof (eventList[eventList[key].inherit]) !== "undefined") {
            eventList[key].inherit = {
                anchor: eventList[eventList[key].inherit].anchor,
                name: eventList[eventList[key].inherit].simple_name
            };
        } else {
            delete eventList[key].inherit;
        }

        // Search child classes in the json file
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
        events.push(eventList[key]);
    }
    return events;
}

module.exports = plugin;
