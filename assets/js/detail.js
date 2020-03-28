import $ from 'jquery'
import v from 'jquery-validation'
window.jQuery = $
window.$ = $

document.addEventListener('DOMContentLoaded', function () {
  document.getElementById('line-icon').addEventListener('click', shareLine)
  document.getElementById('face-icon').addEventListener('click', shareFacebook)
  document.getElementById('line-icon-down').addEventListener('click', shareLine)
  document
    .getElementById('face-icon-down')
    .addEventListener('click', shareFacebook)
})

function shareLine() {
  const lineIcon = document.getElementById('line-icon')
  const id = lineIcon.getAttribute('data-id')
  const title = lineIcon.getAttribute('data-title')
  var src = window.location.origin + '/details/' + id
  window.open(
    'https://social-plugins.line.me/lineit/share/ui?' +
    'text=' +
    'ขอเชิญร่วมบริจาคโครงการ ' +
    title +
    ' ตามรายละเอียดด้านล่างนี้' +
    '&url=' +
    src
  )
}

function shareFacebook() {
  const faceIcon = document.getElementById('face-icon')
  const id = faceIcon.getAttribute('data-id')
  const pic = faceIcon.getAttribute('data-title')
  const name = faceIcon.getAttribute('data-name')
  const u = window.location.origin + '/details/' + id

  $('meta[property=og\\:image]').attr('content', pic);
  $('meta[property=og\\:description]').attr('content', name);
  console.log($('meta[property=og\\:image]'))
  FB.ui(
    {
      method: 'feed',
      link: encodeURI(u),
      picture: encodeURI(pic),
      name: name
    },
    function (res) {
      console.log(res)
    }
  )
}

$(document).ready(function () {
  $('#go-payment').click(function () {
    v('#donator-form').validate({
      rules: {
        inputAmount: {
          required: true
        }
      },
      messages: {
        inputAmount: {
          required: 'โปรดระบุจำนวนเงิน',
          maxlength: 'โปรดระบุจำนวนเงินไม่เกิด 7 หลัก'
        }
      }
    })

    let data = {
      id: $('#project-id').val(),
      amount: '',
      fullName: ''
    }

    $('input[name="amount"]:checked').val() === 'on'
      ? (data.amount = $('#input-amount').val())
      : (data.amount = $('input[name="amount"]:checked').val())

    $('input[name="fullName"]').val() !== ''
      ? (data.fullName = $('full-name').val())
      : data.fullName == ''

    const csrf_token = $("meta[name='csrf-token']").attr('content')
    if (data.amount != '') {
      $.ajax({
        url: '/transaction',
        data: JSON.stringify(data),
        type: 'POST',
        beforeSend: function (xhr) {
          xhr.setRequestHeader('X-CSRF-Token', csrf_token)
        },
        contentType: 'application/json',
        success: function (res) {
          console.log("success ======")
          console.log(res)
        },
        error: function () {
          console.log("error ======")
        }
      })

    }
  })

  $('input.number').keyup(function (event) {
    // skip for arrow keys
    if (event.which >= 37 && event.which <= 40) return

    // format number
    $(this).val(function (index, value) {
      const valueReplace = value.split(',').join('')
      return valueReplace > 0
        ? value.replace(/\D/g, '').replace(/\B(?=(\d{3})+(?!\d))/g, ',')
        : ''
    })
  })

  $(document).on('click', 'input[name="amount"]', function () {
    $('input[name=inputAmount]').removeClass('error')
    if ($(this).val() === 'on') {
      $('#input-free-style').show()
      $('#label-free-style').hide()
      $('#input-amount').focus()
    } else {
      $('#input-free-style').hide()
      $('#label-free-style').show()
      $('#input-amount').val('')
    }
  })
})
