'use strict';

define('forum/forge-events', [], function() {
	var ForgeEvent = {};
	ForgeEvent.init = () => {
        $('#searchForm').submit(() => false); // prevent enter press to reload the page.

        // Apply filter on first load
        filterEvents($('#searchInput').val());

        const hash = document.location.hash;
        if (hash.length > 1) {
            const selected = document.querySelector(hash);
            if (selected !== null) {
                selected.classList.add("in")
            }
        }

        // Update filter on key input
        $('#searchInput').on('keyup', function() {
            const value = $(this).val();
            const getParam = value.length > 0 ? "?search=" + encodeURIComponent(value) : "";
            window.history.replaceState({},
                document.title,
                window.location.pathname + getParam + window.location.hash);
            filterEvents(value)
        });
	};

	return ForgeEvent;
});

function filterEvents(value) {
    value = value.toLowerCase();
    $('#accordion > .panel').each(function(index) {
        $(this).toggle($(this).attr('data-event-name').toLowerCase().indexOf(value) !== -1);
    });
};
