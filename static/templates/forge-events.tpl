<!-- IMPORT partials/breadcrumbs.tpl -->

<form id="searchForm">
    <div class="input-group forge-event-search">
        <input type="text" class="form-control" id="searchInput" value="{searchValue}" placeholder="[[mff-forge-event:page.search]]" aria-label="[[mff-forge-event:page.search]]">
        <span class="input-group-text"><i class="fa fa-search"></i></span>
    </div>
    <br/>
</form>

<div class="accordion" id="forgeEventList">
    {{{ each event }}}
    <div class="accordion-item">
        <h2 class="accordion-header event-title" id="{../simple_name}">
            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#{../anchor}" aria-expanded="false" aria-controls="{../anchor}">
                {../simple_name}
                <small class="event-package">{../package}</small>
                {{{ if ../annotated }}}
                    <ul class="event-annotations">
                    {{{ if ../has_result }}}
                        <li>@HasResult</li>
                    {{{ end }}}
                    {{{ if ../cancelable }}}
                        <li>@Cancelable</li>
                    {{{ end }}}
                    </ul>
                {{{ end }}}
            </button>
        </h2>
        <div id="{../anchor}" class="accordion-collapse collapse" aria-labelledby="{../simple_name}" data-bs-parent="#forgeEventList">
            <div class="accordion-body">
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
                {{{ if ../children }}}
                <div class="event-children">
                    {{{ each ../children }}}
                    <a class="child-event" data-bs-toggle="collapse" data-bs-target="#{../anchor}" aria-expanded="false" aria-controls="{../anchor}" href="#{../anchor}">{../name}</a>
                    {{{ end }}}
                </div>
                {{{ end }}}
            </div>
        </div>
    </div>
    {{{ end }}}
</div>
