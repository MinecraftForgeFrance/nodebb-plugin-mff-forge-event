<!-- IMPORT partials/breadcrumbs.tpl -->

<form class="form-inline float-right" id="searchForm">
    <div class="input-group mb-2 mr-sm-2 mb-sm-0 forge-event-search">
        <input class="form-control" id="searchInput" value="{searchValue}" type="text" style="margin-right: -8px;" placeholder="Rechercher...">
        <div class="input-group-addon"><i class="fa fa-search"></i></div>
    </div>
    <br/>
</form>
<div class="panel-group" id="accordion">
    <!-- BEGIN event -->
    <div class="panel panel-default" data-event-name="{event.simple_name}">
        <div class="panel-heading event-title">
            <h3 class="panel-title">
                <a data-toggle="collapse" data-parent="#accordion" href="#{event.anchor}">
                    {event.simple_name} <small class="event-package">{event.package}</small>
                </a>
            </h3>
            <!-- IF event.annotated -->
                <div class="text-right">
                    <!-- IF event.has_result -->
                            <div class="event-annotation">@HasResult</div>
                    <!-- END -->
                    <!-- IF event.cancelable -->
                            <div class="event-annotation">@Cancelable</div>
                    <!-- END -->
                </div>
            <!-- END -->
        </div>
        <div id="{event.anchor}" class="panel-collapse collapse">
            <div class="panel-body">
                <!-- IF event.inherit -->
                    <p>
                        <span class="event-inheritance">Extends : </span>
                        <a data-toggle="collapse" data-parent="#accordion" href="#{event.inherit.anchor}">
                            {event.inherit.name}
                        </a>
                    </p>
                <!-- END -->
                <!-- IF event.description -->
                <p>
                    <span class="event-description">Description :</span><br>
                    {event.description}
                </p>
                <!-- END -->
            </div>
            <!-- IF event.children -->
            <div class="panel-footer">
                <!-- BEGIN event.children -->
                <a class="child-event" data-toggle="collapse" data-parent="#accordion" href="#{event.children.anchor}">{event.children.name}</a>
                <!-- END -->
            </div>
            <!-- END -->
        </div>
    </div>
    <!-- END -->
</div>
