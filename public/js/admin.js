var admin = typeof admin === 'undefined' ? {} : admin;

$(function () {
    $(function () {
        $("#selectable").selectable({
            autoRefresh:false,
            stop:function () {
                var result = $("#select-result").empty();
                $(".ui-selected", this).each(function () {
                    var name = $(this).text();
                    result.append(( name ) + ";");
                });
            }
        });
    });
});

function refreshPage() {
    location.reload(true);
}

function validateProfileName(name){
    if(name == "") {
        return false
    }
    return true
}

function validatePipelines(pipelines) {
    if(pipelines == "none") {
        return false
    }
    return true
}

function saveProfile() {
    var name = $(admin.ids.Name).val();
    var pipelines = $(admin.ids.Pipelines).text();
    var name_result = validateProfileName(name);
    var pipelines_result = validatePipelines(pipelines);

    if(name_result && pipelines_result) {
        $.post("http://localhost:9393/profile", "{ \"name\": \""+ name +"\", \"pipelines\": \""+ pipelines +"\" }");
        refreshPage();
    }
}

function deleteProfile(profileName) {
    $.ajax({
        url: "http://localhost:9393/profile/" + profileName,
        type: 'DELETE'
    });
    refreshPage();
}

admin.ids = {
    Name : "#profileName",
    Pipelines : "#select-result"
}

$(document).ready(function () {
    $('#save').click(function () {
        saveProfile();
    });

    $('.delete').click(function (e) {
        e.preventDefault();
        var profileName = jQuery(this).attr("href");

        deleteProfile(profileName);
    });
});


