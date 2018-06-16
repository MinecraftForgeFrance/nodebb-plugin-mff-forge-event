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
        <input class="form-control" id="searchInput" type="text" style="margin-right: -8px;" placeholder="Rechercher...">
    </div>
    <br/>
</form>
<div class="panel-group" id="accordion">
    <!-- BEGIN event -->
    <div class="panel panel-default">
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
<div class="modal fade" id="emptyModal" tabindex="-1" role="dialog" aria-labelledby="emptyModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title text-danger" id="emptyModalLabel">Erreur</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Fermer">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body text-dark">
                Le champs est vide.<br/>
                Opération impossible.
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Fermer</button>
            </div>
        </div>
    </div>
</div>

<script>
window.addEventListener("load", function () {
            let hash = document.location.hash;
            if (hash.length > 1) {
                let selected = document.querySelector(hash);
                if (selected !== null) {
                    selected.classList.add("in")
                }
            }
        });
</script>