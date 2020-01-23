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
    const id = $('#cancel-trans').attr("data-payload")
    const csrf_token = $("meta[name='csrf-token']").attr("content")
    $.ajax({
      url: '/cancel_trans',
      data: {
        id: id,
        status: "cancel"
      },
      type: 'PUT',
      beforeSend: function(xhr) {
        xhr.setRequestHeader("X-CSRF-Token", csrf_token);
      },
      dataType: 'json',
      success: function () {
        location.reload();
        $(".loader").removeClass("is-active");
      },
      error: function () {
        $('.modal-body #confirm').hide();
        $('.modal-body #error').show();
      }
    })
  })
})