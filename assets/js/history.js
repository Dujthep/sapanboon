import $ from 'jquery';
window.jQuery = $;
window.$ = $;

$(document).ready(function () {
  $("#confirm-modal").on("show.bs.modal", function(event) {
    $('.modal-body #confirm').show();
    $('.modal-body #error').hide();
    const button = $(event.relatedTarget)
    const modal = $(this)
    modal.find(".modal-body input").val(button.data('whatever'))
  })
})

function viewSlip(imgSlip) {
  $('.modal-body #img').attr("src", imgSlip);
}

function cancelTrans() {
  const transId = $(".modal-body input").val();
  $(".loader").addClass("is-active");
  $.ajax({
    url: '/cancel_trans',
    data: { transactionId: transId },
    type: 'POST',
    dataType: 'json',
    success: function(data){
      location.reload();
      $(".loader").removeClass("is-active");
    },
    error: function(data){
      $('.modal-body #confirm').hide();
      $('.modal-body #error').show();
    }
  })
}