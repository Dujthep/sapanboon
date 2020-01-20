import $ from 'jquery';

$("#amount-error").hide()
  $('#line-shared').attr('data-url',window.location.href);
  $('#line-shared').css('background-image','url(/assets/icon-line-9917a76169d3aa1fdc29b27b714070bfbb070f9204aa1c383a953ee1e7a0a405.svg) !important')
  $('#line-shared').css('width','40px !important')

  function checkform() {
    if ("<%= current_user %>" != '') {
      return true
    } else {
      alert("กรุณาเข้าสู่ระบบ ก่อนทำรายการ")
      return false
    }
  }

  $(document).ready(function() {

    function hidePayment() {
      $(".prompt-pay-form").hide();
      $(".visa-form").hide();
      $(".qr-code-form").hide();
    }

    $('#donator-form').validate({
      rules : {
        inputAmount: {
          required: true
        }
      },
      messages: {
        inputAmount: {
          required: "โปรดระบุจำนวนเงิน",
          maxlength: "โปรดระบุจำนวนเงินไม่เกิด 7 หลัก"
        }
      }
    });

    $('input.number').keyup(function(event) {
      // skip for arrow keys
      if(event.which >= 37 && event.which <= 40) return;

      // format number
      $(this).val(function(index, value) {
        const valueReplace = value.split(",").join("");
        return valueReplace > 0 ? value.replace(/\D/g, "").replace(/\B(?=(\d{3})+(?!\d))/g, ",") : '';
      });
    });

    $(document).on("change", 'input[name="payment-chanel"]', function() {
      hidePayment();
      if ($(this).val() === "promptPay" || $(this).val() === "qrCode") {
        $(".prompt-pay-form").show();
      } else if ($(this).val() === "visa") {
        $(".visa-form").show();
      }
    });

    $(document).on('click', 'input[name="amount"]', function() {
      $('input[name=inputAmount]').removeClass('error')
      if($(this).val() === "on") {
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