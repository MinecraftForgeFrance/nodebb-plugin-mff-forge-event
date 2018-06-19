<ol class="breadcrumb">
    <li itemscope="itemscope" itemtype="http://data-vocabulary.org/Breadcrumb">
        <a href="/" itemprop="url">
            <span itemprop="title">
                [[global:home]]
            </span>
        </a>
    </li>
    <li component="breadcrumb/current" itemscope="itemscope" itemtype="http://data-vocabulary.org/Breadcrumb" class="active">
        <span itemprop="title">
            Événements Forge
        </span>
    </li>
</ol>
<form class="form-inline float-right">
    <div class="input-group mb-2 mr-sm-2 mb-sm-0">
        <div class="input-group-prepend">
            <div class="input-group-text unselectable"><i class="fa fa-search"></i></div>
        </div>
        <input class="form-control" id="searchInput" value="{searchValue}" type="text" style="margin-right: -8px;" placeholder="Rechercher...">
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
            <div class="text-info">{event.sides}</div>
        </div>
        <div id="{event.anchor}" class="panel-collapse collapse">
            <div class="panel-body">
                <!-- IF event.has_result -->
                    <p>
                        <span class="event-annotation">Annotée : </span><span class="text-info">@HasResult</span>
                    </p>
                <!-- END -->
                <!-- IF event.cancelable -->
                    <p>
                        <span class="event-annotation">Annotée : </span><span class="text-info">@Cancelable</span>
                    </p>
                <!-- END -->
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
                <a data-toggle="collapse" data-parent="#accordion" href="#{event.children.anchor}">{event.children.name}</a>
                <!-- END -->
            </div>
            <!-- END -->
        </div>
    </div>
    <!-- END -->
</div>

<script>
window.addEventListener("load", function () {

            let filterEvents = function(value) {
                value = value.toLowerCase();
                $("#accordion > .panel").each(function (index) {
                    $(this).toggle($(this).attr("data-event-name").toLowerCase().indexOf(value) !== -1);
                });
            };

            filterEvents($("#searchInput").val());

            let hash = document.location.hash;
            if (hash.length > 1) {
                let selected = document.querySelector(hash);
                if (selected !== null) {
                    selected.classList.add("in")
                }
            }

            $("#searchInput").on("keyup", function () {
                    let value = $(this).val();
                    let getParam = value.length > 0 ? "?search=" + encodeURIComponent(value) : "";
                    window.history.replaceState({},
                        document.title,
                        window.location.pathname + getParam + window.location.hash);
                    filterEvents(value)
                });
        });
</script>