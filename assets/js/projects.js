import $ from 'jquery';
window.jQuery = $;
window.$ = $;

import 'bootstrap';

$(document).ready(function () {
    $("#load-more").click(function() {
        // $.ajax({
        //     url: '/cancel_trans',
        //     data: {
        //         id: id,
        //         status: "cancel"
        //     },
        //     type: 'PUT',
        //     beforeSend: function(xhr) {
        //         xhr.setRequestHeader("X-CSRF-Token", csrf_token);
        //     },
        //     dataType: 'json',
        //     success: function () {
        //         location.reload();
        //         $(".loader").removeClass("is-active");
        //     },
        //     error: function () {
        //         $('.modal-body #confirm').hide();
        //         $('.modal-body #error').show();
        //     }
        // })
    });
});