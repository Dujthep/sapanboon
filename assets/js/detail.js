import $ from 'jquery';
window.jQuery = $;
window.$ = $;

document.addEventListener("DOMContentLoaded", function () {
  document.getElementById("line-icon").addEventListener("click", shareLine);
  document.getElementById("face-icon").addEventListener("click", shareFacebook);
});


function shareLine() {
  const lineIcon = document.getElementById('line-icon')
  const id = lineIcon.getAttribute("data-id");
  const title = lineIcon.getAttribute("data-title");
  var src = window.location.origin + "/details/" + id;
  window.open('https://social-plugins.line.me/lineit/share/ui?' + 'text=' + 'ขอเชิญร่วมบริจาคโครงการ ' + title + ' ตามรายละเอียดด้านล่างนี้' + '&url=' + src);
}


function shareFacebook() {
  const faceIcon = document.getElementById('face-icon')
  const id = faceIcon.getAttribute("data-id");
  const pic = faceIcon.getAttribute("data-title");
  const u = window.location.origin + "/details/" + id;
  window.open(u);
  FB.ui({
    method: 'feed',
    link: u,
    picture: pic,
  }, function (res) { console.log(res) });
}


$(document).ready(function () {

  // $('#donator-form').validate({
  //   rules : {
  //     inputAmount: {
  //       required: true
  //     }
  //   },
  //   messages: {
  //     inputAmount: {
  //       required: "โปรดระบุจำนวนเงิน",
  //       maxlength: "โปรดระบุจำนวนเงินไม่เกิด 7 หลัก"
  //     }
  //   }
  // });

  $("#go-payment").click(function () {
    let csrf_token = document.querySelector("meta[name='csrf-token']").getAttribute("content");

    let data = {
      id: $("#project-id").val(),
      amount: ''
    }

    $('input[name="amount"]:checked').val() === "on" ? data.amount = $('#input-amount').val() : data.amount = $('input[name="amount"]:checked').val()

    $.ajax({
      url: '/transaction',
      type: 'POST',
      data: data,
      beforeSend: function (xhr) {
        xhr.setRequestHeader("X-CSRF-Token", csrf_token);
      },
      dataType: 'json',
      success: function (res) {
        console.log(res);
        // location.reload();
        // $(".loader").removeClass("is-active");
      },
      error: function () {
        // $('.modal-body #confirm').hide();
        // $('.modal-body #error').show();
      }
    })
  })

  $('input.number').keyup(function (event) {
    // skip for arrow keys
    if (event.which >= 37 && event.which <= 40) return;

    // format number
    $(this).val(function (index, value) {
      const valueReplace = value.split(",").join("");
      return valueReplace > 0 ? value.replace(/\D/g, "").replace(/\B(?=(\d{3})+(?!\d))/g, ",") : '';
    });
  });

  $(document).on('click', 'input[name="amount"]', function () {
    $('input[name=inputAmount]').removeClass('error')
    if ($(this).val() === "on") {
      $("#input-free-style").show();
      $("#label-free-style").hide();
      $("#input-amount").focus();
    } else {
      $("#input-free-style").hide();
      $("#label-free-style").show();
      $("#input-amount").val('');
    }
  })
});

  // $("#amount-error").hide()
  // $('#line-shared').attr('data-url',window.location.href);
  // $('#line-shared').css('background-image','url(/assets/icon-line-9917a76169d3aa1fdc29b27b714070bfbb070f9204aa1c383a953ee1e7a0a405.svg) !important')
  // $('#line-shared').css('width','40px !important')

  // function hidePayment() {
  //   $(".prompt-pay-form").hide();
  //   $(".visa-form").hide();
  //   $(".qr-code-form").hide();
  // }

  // $(document).on("change", 'input[name="payment-chanel"]', function() {
  //   hidePayment();
  //   if ($(this).val() === "promptPay" || $(this).val() === "qrCode") {
  //     $(".prompt-pay-form").show();
  //   } else if ($(this).val() === "visa") {
  //     $(".visa-form").show();
  //   }
  // });


