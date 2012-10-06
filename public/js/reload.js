$(document).ready(
    timedRefresh(20000)
);

function timedRefresh(timeoutPeriod) {
    setTimeout("location.reload(true);",timeoutPeriod);
}