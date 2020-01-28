import { PromptPayQR } from './qrcode/promptpay-qr'
import { QRCode } from './qrcode/qrcode'

document.addEventListener('DOMContentLoaded', function() {
  generateQR()
})

function generateQR() {
  var qr_dom = $('#qrcode')
  var txt = PromptPayQR.gen_text('0955198387', 5) // Number 5 is amount.
  qr_dom.innerHTML = ''
  new QRCode(qrcode, txt)
}
