'use strict';

define('forum/forge-events', [], function() {
	const ForgeEvent = {};
	ForgeEvent.init = () => {
        $('#searchForm').submit(() => false); // prevent enter press to reload the page.
        const searchInput = document.getElementById('searchInput');
        // Apply filter on first load
        filterEvents(searchInput.value);

        const hash = document.location.hash;
        if (hash.length > 1) {
            const selected = document.querySelector(hash);
            if (selected !== null) {
                require(['bootstrap'], function (bootstrap) {
                    new bootstrap.Collapse(selected, {
                        toggle: true
                    })
                });
            }
        }

        searchInput.addEventListener('keyup', function() {
            const value = searchInput.value;
            const getParam = value.length > 0 ? "?search=" + encodeURIComponent(value) : "";
            window.history.replaceState({}, document.title, window.location.pathname + getParam + window.location.hash);
            filterEvents(value)
        });
	};

	return ForgeEvent;
});

function filterEvents(value) {
    value = value.toLowerCase();
    document.querySelectorAll('#forgeEventList > .accordion-item').forEach(function (element) {
        element.style.display = element.firstElementChild.id .toLowerCase().indexOf(value) !== -1 ? 'block' : 'none';
    });
}
