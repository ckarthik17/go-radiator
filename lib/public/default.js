//function updatePipelines(waitTime) {
//    setTimeout(function () {
//        $('div[name*="pipeline_wrapper"]').each(function() {
//                $.get("http://localhost:9393/pipeline/" + $(this).attr('class'), function(data) {
//                    $(this).html(data);
//                });
//
//                    // TODO: Just call updatePipelines(1000) again for never ending loop
//                    // TODO: there is a way to stop the browser looking like its always loading
//                    // TODO: look into error message loading and what happens on anything other than a 200 ok?
//
//            }
//        );
//    }, waitTime);
//}

function updatePipelines() {
    setTimeout(function() {
        $('div[name*="pipeline_wrapper"]').each(function() {
            updatePipeline(this);
        });
        updatePipelines();
    }, 15000);
}

function updatePipeline(pipeline_name) {
    $.ajax({
        type: "GET",
        url: "http://localhost:9393/pipeline/" + $(pipeline_name).attr('class'),

        async: true, /* If set to non-async, browser shows page as "Loading.."*/
        cache: false,
        timeout:14000, /* Timeout in ms */

        success: function(data) { /* called when request to barge.php completes */
            $(pipeline_name).html(data);
            /* Add response to a .msg div (with the "new" class)*/
//            setTimeout(
//                'updatePipelines()', /* Request next message */
//                15000 /* ..after 15 seconds */
//            );
        },
        error: function(XMLHttpRequest, textStatus, errorThrown) {
//            addmsg("error", textStatus + " (" + errorThrown + ")");
//            setTimeout(
//                'updatePipelines()', /* Try again after.. */
//                "15000"); /* milliseconds (15seconds) */
        }
    });
}
//
//function addmsg(type, msg) {
//    /* Simple helper to add a div.
//     type is the name of a CSS class (old/new/error).
//     msg is the contents of the div */
//    $("#messages").append(
//        "<div class='msg " + type + "'>" + msg + "</div>"
//    );
//}

$(document).ready(function() {
        updatePipelines();
    }
);