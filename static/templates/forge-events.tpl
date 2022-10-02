<!-- IMPORT partials/breadcrumbs.tpl -->

<form class="form-inline float-right" id="searchForm">
    <div class="input-group mb-2 mr-sm-2 mb-sm-0 forge-event-search">
        <input class="form-control" id="searchInput" value="{searchValue}" type="text" style="margin-right: -8px;" placeholder="[[mff-forge-event:page.search]]">
        <div class="input-group-addon"><i class="fa fa-search"></i></div>
    </div>
    <br/>
</form>
<div class="panel-group" id="accordion">
    {{{ each event }}}
    <div class="panel panel-default" data-event-name="{../simple_name}">
        <div class="panel-heading event-title">
            <h3 class="panel-title">
                <a data-toggle="collapse" data-parent="#accordion" href="#{../anchor}">
                    {../simple_name} <small class="event-package">{../package}</small>
                </a>
            </h3>
            {{{ if ../annotated }}}
                <div class="text-right">
                    {{{ if ../has_result }}}
                        <div class="event-annotation">@HasResult</div>
                    {{{ end }}}
                    {{{ if ../cancelable }}}
                        <div class="event-annotation">@Cancelable</div>
                    {{{ end }}}
                </div>
            {{{ end }}}
        </div>
        <div id="{../anchor}" class="panel-collapse collapse">
            <div class="panel-body">
                {{{ if ../inherit }}}
                    <p>
                        <span class="event-inheritance">[[mff-forge-event:event.extends]]</span>
                        <a data-toggle="collapse" data-parent="#accordion" href="#{../inherit.anchor}">
                            {../inherit.name}
                        </a>
                    </p>
                {{{ end }}}
                {{{ if ../description }}}
                <p>
                    <span class="event-description">[[mff-forge-event:event.description]]</span><br>
                    {../description}
                </p>
                {{{ end }}}
            </div>
            {{{ if ../children }}}
            <div class="panel-footer">
                {{{ each ../children }}}
                <a class="child-event" data-toggle="collapse" data-parent="#accordion" href="#{../anchor}">{../name}</a>
                {{{ end }}}
            </div>
            {{{ end }}}
        </div>
    </div>
    {{{ end }}}
</div>
