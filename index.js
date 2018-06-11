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
            title: "",
            iconClass: "",
            text: ""
        }
    ]);

    callback(null, menu);
};

function renderForgeEvent(req, res) {
    res.render("client/plugins/forge-event");
}

module.export = plugin;
