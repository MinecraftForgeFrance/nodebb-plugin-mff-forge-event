<ol class="breadcrumb">
    <li itemscope="itemscope" itemtype="http://data-vocabulary.org/Breadcrumb">
        <a href="/" itemprop="url">
            <span itemprop="title">
                [[global:home]]
            </span>
        </a>
    </li>
    <li component="breadcrumb/current" itemscope="itemscope" itemtype="http://data-vocabulary.org/Breadcrumb"
        class="active">
        <span itemprop="title">
            Événements Forge
        </span>
    </li>
</ol>
<h2>Accordion Example</h2>
<p><strong>Note:</strong> The <strong>data-parent</strong> attribute makes sure that all collapsible elements under the
    specified parent will be closed when one of the collapsible item is shown.</p>
<div class="panel-group" id="accordion">
    <!-- BEGIN event -->
    <div class="panel panel-default">
        <div class="panel-heading event-title">
            <h3 class="panel-title">
                <a data-toggle="collapse" data-parent="#accordion" href="#{event.formated_name}">{event.simple_name}</a>
                <small class="event-package">{event.package}</small>
            </h3>
            <div class="event-sides">{event.sides}</div>
        </div>
        <!-- IF @first -->
        <div id="{event.formated_name}" class="panel-collapse collapse in">
        <!-- ENDIF @first -->
        <!-- IF !@first -->
        <div id="{event.formated_name}" class="panel-collapse collapse">
        <!-- ENDIF !@first -->
            <div class="panel-body">
                <!-- IF event.description -->
                <p>
                    <span class="event-description">Description :</span><br>
                    {event.description}
                </p>
                <!-- END -->
                <p>
                    <span class="event-heritage">Hérite de :</span><br>
                    {event.inherit}
                </p>
            </div>
            <!-- IF event.children -->
            <div class="panel-footer">
                <!-- BEGIN event.children -->
                <a href="#{event.children.formated_name}">{event.children.full_name}</a>
                <!-- END -->
            </div>
            <!-- END -->
        </div>
    </div>
    <!-- END -->
</div>
