import { PromptPayQR } from './qrcode/promptpay-qr'
import $ from 'jquery'
window.jQuery = $
window.$ = $

document.addEventListener('DOMContentLoaded', function() {
  generateQR()
})

function generateQR() {
  // PromptPayQR.
}


// $(document).ready(function () {
//   var qr_dom = $("#qrcode")
//    var txt = PromptPayQR.gen_text('0994000001711', "test");
//   qr_dom.innerHTML = "";
//   qr = new QRCode(qrcode, txt)
//   /*if(txt){
//     new QRCode(qr_dom, txt);
//   }*/

// })
