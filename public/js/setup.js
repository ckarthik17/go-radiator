$(document).ready(function () {

    $("#profiles select").change(function() {
        var prefix = location.protocol+'//'+location.hostname+(location.port ? ':'+location.port: '');
        var url = prefix + "/radiator/" + $("#profiles select option:selected").html();
        $(location).attr('href',url);
    });

});