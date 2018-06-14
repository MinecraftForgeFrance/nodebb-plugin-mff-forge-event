/* globals $ */

$('#emptyModal').modal({show: false});
$(function () {
    $('#button').click(function () {
        if ($('#searchfield').val() === '') {
            $('#emptyModal').modal('show');
        }
    });
});

$(document).ready(function () {
    $("#searchInput").on("keyup", function () {
        let value = $(this).val().toLowerCase();
        $("#accordion div").filter(function () {
            $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
        });
    });
});
