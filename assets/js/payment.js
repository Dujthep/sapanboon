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
      // onSubmit()
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
  const file = $('#upload')[0].files[0]
  const id = $('#transactionId').val()

  if (file != null) {
    $('.loader').addClass('is-active')
    var formData = new FormData()
    formData.append('file', file)
    formData.append('id', id)
    $.ajax({
      url: 'https://beta.api.sapanboon.org/uploadSlip',
      data: formData,
      processData: false,
      contentType: false,
      type: 'POST',
      success: function(data) {
        document.location.href = '/success'
      },
      error: function(data) {
        $('#error-text').text(
          'อัพโหลดสลิปล้มเหลว กรุณาลองใหม่ภายหลัง หรือติดต่อเจ้าหน้าที่'
        )
        $('#error-modal').modal('show')
        $('.loader').removeClass('is-active')
      }
    })
  } else {
    $('#error-text').text('กรุณาแนบหลักฐานการโอน')
    $('#error-modal').modal('show')
  }
}
