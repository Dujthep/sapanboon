import $ from 'jquery';
window.jQuery = $;
window.$ = $;

import 'bootstrap';

$(document).ready(function () {
  $("td #view-slip").click(function() {
    var index= $('#view-slip').index(this);
    $('.modal-body #img').attr("src", $(this).attr("data-payload"));
  })

  $('.modal-body #error').hide();
  $(".modal #btn-cancel-trans").click(function() {
    const id = $('#cancel-trans').attr("data-payload")
    const csrf_token = $("meta[name='csrf-token']").attr("content")
    $.ajax({
      url: '/update_transaction',
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


  $("td #file-upload").change(function() {
    readURL(this);
  })

  $("#btn-confirm-slip").click(function() {
    const url = 'http://localhost:8080'
    const file = $("td #file-upload")[0].files[0]
    const id = $("td #file-upload").attr("data-payload")
    if (file) {
      $('#slip-confirm-modal').modal('hide');
      var formData = new FormData();
      formData.append('file', file);
      formData.append('id', id);
      $.ajax({
        url: url + '/uploadSlipPhx',
        data: formData,
        processData: false,
        contentType: false,
        type: 'POST',
        success: function(imagePath){
          $.ajax({
            url: '/update_transaction',
            data: {
              id: history_id,
              imageSlip: imagePath
            },
            type: 'PUT',
            beforeSend: function(xhr) {
              xhr.setRequestHeader('X-CSRF-Token', csrf_token)
            },
            dataType: 'json',
            success: function(data) {
              console.log(data)
              location.reload();
            },
            error: function(data) {
              $('#error-modal').modal('show')
            }
          })
        },
        error: function(data){
          $('#error-modal').modal('show')
        },
      });
    }
  })

  function readURL(input) {
    if (input.files && input.files[0]) {
      $('#slip-confirm-modal').modal('show');
      var reader = new FileReader();
      reader.onload = function(e) {
        $('#slip-confirm-modal .modal-body #img').attr("src", e.target.result);
      }
      reader.readAsDataURL(input.files[0]);
    }
  }

})