import $ from 'jquery'
window.jQuery = $
window.$ = $

import 'bootstrap'

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
  // console.log(u);
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
  let page = 1

  function currencyFormat(currency) {
    const c = parseFloat(currency)
    return c.toString().replace(/(\d)(?=(\d\d\d)+(?!\d))/g, '$1,')
  }

  function calculatePercent(donation, budget) {
    if (donation > 0 && budget > 0) {
      var percent = Math.round((donation / budget) * 100)
      if (percent > 0) {
        return percent
      } else {
        return ''
      }
    } else {
      return null
    }
  }

  function formatDate(date) {
    var monthNames = [
      'ม.ค.',
      'ก.พ.',
      'มี.ค.',
      'เม.ย.',
      'พ.ค.',
      'มิ.ย.',
      'ก.ค.',
      'ส.ค.',
      'ก.ย.',
      'ต.ค.',
      'พ.ย.',
      'ธ.ค.'
    ]
    var d = new Date(date)

    var day = d.getDate()
    var monthIndex = d.getMonth()
    var year = d.getFullYear() + 543

    return day + ' ' + monthNames[monthIndex] + ' ' + year
  }

  function diffDate(dateTo, dateFrom) {
    var oneDay = 24 * 60 * 60 * 1000
    return Math.round(
      Math.abs(
        (new Date(dateTo).getTime() - new Date(dateFrom).getTime()) / oneDay
      )
    )
  }

  function checkStatusDate(item) {
    if (item.projectStatus === 'active') {
      return diffDate(item.dateTo, Date.now())
    } else if (item.projectStatus === 'pending') {
      return diffDate(item.dateTo, item.dateFrom)
    } else {
      return '-'
    }
  }

  function genDom(data) {
    // console.log(data)
    return `
      <section class="col-lg-4 col-md-6 col-sm-6 col-xs-12 pb-5">
        <section class="card">
          <div class="card-body">
            <section class="card-title" title="ข้อความเต็ม">
              <span class="text-large text-dark">
                SPB${data.code}
              </span>
              <span class="text-large">
                ${data.name}
              </span>
            </section>

            <div class="row">
              <div class="top-right px-2">
                <a id='line-icon' data-id="${
                  data.projectId
                }" data-title="${data.name}">
                  <img class="icon-detail pointer" src="/images/line-icon.svg">
                </a>
                <a id="face-icon" data-id="${
                  data.id
                }" data-title="${data.images}">
                  <img class="icon-detail pointer" src="/images/facebook-icon.svg">
                </a>
              </div>
            </div>

            <section>
              <img class="card-img-top" src="${
                data.images
              }" alt="project image">
            </section>

            <section class="project-progress">
              <div class="text-between text-small">
                <span>เป้าหมาย</span>
                <span>ระยะเวลาในการระดมทุน</span>
              </div>
              <div class="text-between">
                <h2 class="text-large">${currencyFormat(data.budget)}</h2>
                <span class="text-normal">${formatDate(
                  data.dateFrom
                )} - ${formatDate(data.dateTo)}</span>
              </div>
              <div class="progress">
                <div class="progress-bar bg-warning" role="progressbar" 
                  style="width: ${
                    calculatePercent(data.donation, data.budget)
                      ? calculatePercent(data.donation, data.budget) + '%'
                      : ''
                  }" 
                  aria-valuenow="${
                    calculatePercent(data.donation, data.budget)
                      ? calculatePercent(data.donation, data.budget)
                      : ''
                  }" 
              <div class="progress" style="height: 26px;">
                <div class="progress-bar bg-warning" role="progressbar"
                  style="height: 26px; width: ${ calculatePercent(data.donation, data.budget) ? calculatePercent(data.donation, data.budget) + "%" : ""}"
                  aria-valuenow="${ calculatePercent(data.donation, data.budget) ? calculatePercent(data.donation, data.budget) : ""}"
                  aria-valuemin="0" aria-valuemax="100">
                  ${
                    calculatePercent(data.donation, data.budget)
                      ? calculatePercent(data.donation, data.budget) + '%'
                      : ''
                  }
                </div>
              </div>
              <div>
                <span class="text-normal">เหลือเวลาอีก${checkStatusDate(
                  data
                )}วัน</span>
              </div>
            </section>

            <section class="card-text" title="ข้อความเต็ม">
              ${data.introduce}
            </section>

            <a id="${moreId(data.projectStatus)}" class="${moreClass(data.projectStatus)}" href="/details/${data.id}">
              ${moreText(data.code, data.projectStatus)}
            </a>

          </div>
        </section>
      </section>
    `
  }

  function moreId(status) {

    if (status == 'active') {
      return 'go-detail'
    }

    if (status == 'complete') {
      return 'go-detail-complete'
    }

    if (status == 'expire') {
      return 'go-detail-expire'
    }

    if (status == 'pending') {
      return 'go-detail-pending'
    }
  }

  function moreText(code, status) {
    
    if (status == 'active') {
      return 'ร่วมบริจาค SPB' + code
    }

    if (status == 'complete') {
      return 'สำเร็จแล้ว'
    }

    if (status == 'expire') {
      return 'หมดเวลาระดมทุน'
    }

    if (status == 'pending') {
      return 'ยังไม่ถึงเวลาระดมทุน'
    }
  }

  function moreClass(status) {
    if (status == 'active') {
      return 'btn btn-primary btn-block'
    }
    return 'btn btn-secondary btn-block'
  }

  $('#search-box').on('keydown', function(e) {
    if (e.which === 13) {
      // console.log(window.location, $(this).val())
      const csrf_token = $("meta[name='csrf-token']").attr('content')
      const url = window.location.origin
      // console.log(url)
      $.ajax({
        url: url + `/search/?param=${$(this).val()}`,
        type: 'GET',
        beforeSend: function(xhr) {
          xhr.setRequestHeader('X-CSRF-Token', csrf_token)
        },
        contentType: 'application/json',
        success: function(data) {
          $('#all').addClass('active')
          $('#active').removeClass('active')
          $('#complete').removeClass('active')

          $('#project-card').empty()
          $.each(data, function(index, d) {
            $('#project-card').append(genDom(d))
          })
          // location.reload();
        },
        error: function() {}
      })
    }
  })

  $('#load-more').click(function() {
    // console.log(window.location);
    page++
    $.get(`/load_more${window.location.search}&page=${page}`, function(json) {
      $.each(json, function(index, data) {
        $('#project-card').append(genDom(data))
      })
    })
  })
})
