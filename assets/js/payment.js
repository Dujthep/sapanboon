import { PromptPayQR } from './qrcode/promptpay-qr'
import { QRCode } from './qrcode/qrcode'
import $ from 'jquery'
window.jQuery = $
window.$ = $

document.addEventListener('DOMContentLoaded', function() {
  onGenerateQR()
  addEventChangeToUploadButtonID()
  addEventClickToConfirmPaymentID()
})

function onGenerateQR() {
  var qr_dom = $('#qrcode')
  var txt = PromptPayQR.gen_text('0955198387', $('#amount').val())
  qr_dom.innerHTML = ''
  new QRCode(qrcode, txt)
}

function addEventChangeToUploadButtonID() {
  var upload = document.getElementById('upload')
  if (upload) {
    upload.addEventListener('change', function() {
      attachedFile()
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

function attachedFile() {
  const file = $('#upload')[0].files[0]
  if (file) {
    $('#fileName').text(file.name)
    $('#btn-upload').css('background-color', '#ffbb42')
    $('#conform-payment').prop('disabled', false)
  }
}

function onSubmit() {
  const url = $("#url-api").val()
  console.log(url)
  const file = $('#upload')[0].files[0]
  const transactionId = $('#transactionId').val()
  const csrf_token = $("meta[name='csrf-token']").attr('content')
  if (file != null) {
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
            imageSlip: imagePath
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
            alert('อัพโหลดสลิปล้มเหลว กรุณาลองใหม่ภายหลัง หรือติดต่อเจ้าหน้าที่')
          }
        })
      },
      error: function(data) {
        alert('อัพโหลดสลิปล้มเหลว กรุณาลองใหม่ภายหลัง หรือติดต่อเจ้าหน้าที่')
      }
    })
  } else {
    alert('กรุณาแนบหลักฐานการโอน')
  }
}
