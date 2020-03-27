import $ from 'jquery'
window.jQuery = $
window.$ = $

import 'bootstrap'

$(document).ready(function() {
  $('td #view-slip').click(function() {
    $('.modal-body #img').attr('src', $(this).attr('data-payload'))
  })

  $('.dropdown-menu #view-slip').click(function() {
    $('.modal-body #img').attr('src', $(this).attr('data-payload'))
  })

  $('.modal-body #error').hide()
  $('.modal #btn-cancel-trans').click(function() {
    const transId = $('#cancel-trans').attr('data-payload')
    const csrf_token = $("meta[name='csrf-token']").attr('content')
    const url = $('#url-api').val()
    $.ajax({
      url: url + '/updateStatus',
      data: JSON.stringify({
        id: transId,
        status: 'cancel'
      }),
      type: 'PUT',
      beforeSend: function(xhr) {
        xhr.setRequestHeader('X-CSRF-Token', csrf_token)
      },
      contentType: 'application/json',
      success: function() {
        location.reload()
      },
      error: function() {
        $('.modal-body #confirm').hide()
        $('.modal-body #error').show()
      }
    })
  })

  // $('#file-upload').change(function() {
  //   readURL(this)
  // })

  // $('#btn-confirm-slip').click(function() {
  //   const url = $('#url-api').val()
  //   const file = $('td #file-upload')[0].files[0]
  //   const transId = $('td #file-upload').attr('data-payload')
  //   const csrf_token = $("meta[name='csrf-token']").attr('content')

  //   console.log('url', url)
  //   console.log('file', file)
  //   console.log('transId', transId)
  //   console.log('csrf_token', csrf_token)

  //   if (file) {
  //     $('.loader').addClass('is-active')
  //     var formData = new FormData()
  //     formData.append('file', file)
  //     formData.append('id', transId)
  //     $('#slip-confirm-modal').modal('hide')

  //     $.ajax({
  //       url: url + '/uploadSlipPhx',
  //       data: formData,
  //       processData: false,
  //       contentType: false,
  //       type: 'POST',
  //       success: function(imagePath) {
  //         console.log('Upload success')
  //         $.ajax({
  //           url: '/api/transaction',
  //           data: {
  //             transId: transId,
  //             imgSlip: imagePath
  //           },
  //           type: 'PUT',
  //           beforeSend: function(xhr) {
  //             xhr.setRequestHeader('X-CSRF-Token', csrf_token)
  //           },
  //           dataType: 'json',
  //           success: function() {
  //             location.reload()
  //           },
  //           error: function() {
  //             $('.modal-body #confirm').hide()
  //             $('.modal-body #error').show()
  //             $('.loader').removeClass('is-active')
  //           }
  //         })
  //       },
  //       error: function(data) {
  //         $('#error-modal').modal('show')
  //         $('.modal-body #error').show()
  //         $('.loader').removeClass('is-active')
  //       }
  //     })
  //   }
  // })

  // function readURL(input) {
  //   if (input.files && input.files[0]) {
  //     $('#slip-confirm-modal').modal('show')
  //     var reader = new FileReader()
  //     reader.onload = function(e) {
  //       $('#slip-confirm-modal .modal-body #img').attr('src', e.target.result)
  //     }
  //     reader.readAsDataURL(input.files[0])
  //   }
  // }
})
