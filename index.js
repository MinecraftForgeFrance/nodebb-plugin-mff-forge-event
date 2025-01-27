const jsonfile = require('jsonfile');

const helpers = require.main.require('./src/controllers/helpers');
const routeHelpers = require.main.require('./src/routes/helpers');

const MFFForgeEventPlugin = {
    parsedEvents: undefined,
    // Init the plugin
    async init(params) {
        const { router } = params;

        router.get('/forgeevents', (req, res) => res.status(301).redirect('/forge-events'));
        routeHelpers.setupPageRoute(router, '/forge-events', renderForgeEvent);
        router.get('/discordapi/forgeevents', getForgeEvent);

        MFFForgeEventPlugin.parsedEvents = parseForgeEventJson();
    },
    async addNavigation(menu) {
        menu.push({
            route: '/forge-events',
            title: "[[mff-forge-event:menu.title]]",
            iconClass: "fa-burst",
            textClass: "visible-xs-inline",
            text: "Forge Events"
        });
        return menu;
    }
};

function renderForgeEvent(req, res) {
    let searchValue = req.query.search === undefined ? "" : req.query.search;
    res.render('forge-events', {
        title: '[[mff-forge-event:page.title]]',
        event: MFFForgeEventPlugin.parsedEvents,
        breadcrumbs: helpers.buildBreadcrumbs([{ text: '[[mff-forge-event:menu.title]]' }]),
        searchValue: searchValue
    });
}

function getForgeEvent(req, res) {
    return searchForgeEvent(req, res, MFFForgeEventPlugin.parsedEvents);
}

function searchForgeEvent(req, res, events) {
    let eventResult = {};
    let eventName = req.query.term;
    if (typeof (eventName) !== 'undefined') {
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
        if (Object.getOwnPropertyNames(eventResult).length === 0) {
            return res.status(200).send({ data: eventResult });
        }
    }
    else {
        return res.status(400).json({ message: 'Missing arguments' });
    }

    return res.status(200).json({ data: eventResult });
}

function parseForgeEventJson() {
    let eventList = jsonfile.readFileSync(__dirname + '/forge_events.json');
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

module.exports = MFFForgeEventPlugin;
