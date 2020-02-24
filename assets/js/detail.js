import $ from 'jquery'
window.jQuery = $
window.$ = $

document.addEventListener('DOMContentLoaded', function() {
  document.getElementById('line-icon').addEventListener('click', shareLine)
  document.getElementById('face-icon').addEventListener('click', shareFacebook)
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
  const u = window.location.origin + '/details/' + id
  console.log(u)
  window.open(u)
  FB.ui(
    {
      method: 'feed',
      link: u,
      picture: pic
    },
    function(res) {
      console.log(res)
    }
  )
}

$(document).ready(function() {
  $('#go-payment').click(function() {
    let csrf_token = document
      .querySelector("meta[name='csrf-token']")
      .getAttribute('content')

    let data = {
      id: $('#project-id').val(),
      amount: '',
      fullName: ''
    }

    $('input[name="amount"]:checked').val() === 'on'
      ? (data.amount = $('#input-amount').val())
      : (data.amount = $('input[name="amount"]:checked').val())
    
    $('input[name="fullName"]').val() !== ''
      ? data.fullName = $('full-name').val()
      : data.fullName == ''

    $.ajax({
      url: '/transaction',
      type: 'POST',
      data: data,
      beforeSend: function(xhr) {
        xhr.setRequestHeader('X-CSRF-Token', csrf_token)
      },
      dataType: 'json',
      success: function(res) {
        console.log(res)
      },
      error: function() {}
    })
  })

  $('input.number').keyup(function(event) {
    // skip for arrow keys
    if (event.which >= 37 && event.which <= 40) return

    // format number
    $(this).val(function(index, value) {
      const valueReplace = value.split(',').join('')
      return valueReplace > 0
        ? value.replace(/\D/g, '').replace(/\B(?=(\d{3})+(?!\d))/g, ',')
        : ''
    })
  })

  $(document).on('click', 'input[name="amount"]', function() {
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
