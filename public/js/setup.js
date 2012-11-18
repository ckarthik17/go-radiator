$(document).ready(function () {

    $(".profile-select select").change(function() {
        var prefix = location.protocol+'//'+location.hostname+(location.port ? ':'+location.port: '');
        var url = prefix + "/radiator/" + $(".profile-select select option:selected").html();
        $(location).attr('href',url);
    });

});