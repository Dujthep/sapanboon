import { PromptPayQR } from './qrcode/promptpay-qr'
import { QRCode } from './qrcode/qrcode'
import 'bootstrap';
import $ from 'jquery';
window.jQuery = $;
window.$ = $;

document.addEventListener('DOMContentLoaded', function() {
  $("#upload").val('');
  onGenerateQR()
  addEventChangeToUploadButtonID()
  addEventClickToConfirmPaymentID()
})

function onGenerateQR() {
  var qr_dom = $('#qrcode')
  var txt = PromptPayQR.gen_text('0994000001711', $('#amount').val())
  qr_dom.innerHTML = ''
  new QRCode(qrcode, txt)
}

function addEventChangeToUploadButtonID() {
  var upload = document.getElementById('upload')
  if (upload) {
    upload.addEventListener('change', function() {
      attachedFile()
      readURL(this)
    })
  }
}

function addEventClickToConfirmPaymentID() {
  var confirmPayment = document.getElementById('confirm-payment')
  if (confirmPayment) {
    confirmPayment.addEventListener('click', function() {
      onSubmit()
    })
  }
}

function readURL(input) {
  if (input.files && input.files[0]) {
    var reader = new FileReader();
    reader.onload = function(e) {
      $('#view-img').attr("src", e.target.result);
    }
    reader.readAsDataURL(input.files[0]);
  }
}

function attachedFile() {
  const file = $('#upload')[0].files[0]
  if (file) {
    $('#fileName').text(file.name)
    $('#btn-upload').css('background-color', '#ffbb42')
  }
}

function onSubmit() {
  const url = $("#url-api").val()
  const file = $('#upload')[0].files[0]
  const transactionId = $('#transactionId').val()
  const csrf_token = $("meta[name='csrf-token']").attr('content')
  if (file) {
    $(".loader").addClass("is-active");
    var formData = new FormData()
    formData.append('file', file)
    formData.append('id', transactionId)

    $.ajax({
      url: url + '/uploadSlipPhx',
      data: formData,
      processData: false,
      contentType: false,
      type: 'POST',
      success: function(imagePath) {
        $.ajax({
          url: '/api/transaction',
          data: {
            transId: transactionId,
            imgSlip: imagePath
          },
          type: 'PUT',
          beforeSend: function(xhr) {
            xhr.setRequestHeader('X-CSRF-Token', csrf_token)
          },
          dataType: 'json',
          success: function(data) {
            window.location.href = '/success/' + data.data.id
          },
          error: function(data) {
            $("#error-text").text("อัพโหลดสลิปล้มเหลว กรุณาลองใหม่ภายหลัง หรือติดต่อเจ้าหน้าที่");
            $('#error-modal').modal('show')
            $(".loader").removeClass("is-active");
          }
        })
      },
      error: function(data) {
        $('#error-modal').modal('show')
      }
    })
  } else {
    $("#error-text").text("กรุณาแนบหลักฐานการโอน");
    $('#error-modal').modal('show')
  }
}
