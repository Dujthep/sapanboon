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
  const file = $('#upload')[0].files[0]
  const id = $('#transactionId').val()
  const projectId = $('#projectId').val()
  const history_id = $('#history_id').val()

  if (file != null) {
    var formData = new FormData()
    formData.append('file', file)
    formData.append('id', id)

    $.ajax({
      url: 'http://localhost:8080/uploadSlipPhx',
      data: formData,
      processData: false,
      contentType: false,
      type: 'POST',
      success: function(data) {
        var image = "https://minio.sapanboon.org/sapanboon/5d274d08403c12000113676dimage5"
        $.ajax({
          url: '/update_transaction',
          data: {
            post: {
              historyId: history_id,
              image: image
            }
          },
          type: 'POST',
          dataType: 'json',
          success: function(data) {
            console.log(data)
          },
          error: function(data) {
            console.log('ERROR ::===============')
          }
        })

      },
      error: function(data) {
        console.log(data)
        alert('อัพโหลดสลิปล้มเหลว กรุณาลองใหม่ภายหลัง หรือติดต่อเจ้าหน้าที่')
      }
    })
  } else {
    alert('กรุณาแนบหลักฐานการโอน')
  }
}
