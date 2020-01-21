import $ from 'jquery';
window.jQuery = $;
window.$ = $;

$(document).ready(function () {
  $("#view-slip").on("click", function () {
    $('.modal-body #img').attr("src", $(this).attr("data"));
  })
  $('.modal-body #error').hide();
  $(".modal #btn-cancel-trans").on("click", function() {
    $(".loader").addClass("is-active");
    const transId = $('#cancel-trans').attr("data-payload")
    // $.ajax({
    //   url: '/cancel_trans',
    //   data: { transactionId: transId },
    //   type: 'POST',
    //   dataType: 'json',
    //   success: function (data) {
    //     location.reload();
    //     $(".loader").removeClass("is-active");
    //   },
    //   error: function (data) {
    //     $('.modal-body #confirm').hide();
    //     $('.modal-body #error').show();
    //   }
    // })
  })
})