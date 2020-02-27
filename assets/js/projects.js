import $ from 'jquery';
window.jQuery = $;
window.$ = $;

import 'bootstrap';

$(document).ready(function () {
  let page = 1;

  function currencyFormat(currency) {
    const c = parseFloat(currency);
    return c.toString().replace(/(\d)(?=(\d\d\d)+(?!\d))/g, "$1,")
  }

  function calculatePercent(donation, budget) {
    percent = Math.round((donation / budget) * 100)
    if (percent < 1 && percent > 0)
      return 1
    else
      return percent
    end
  }

  function formatDate(date) {
    var monthNames = [
      "ม.ค.", "ก.พ.", "มี.ค.", "เม.ย.", "พ.ค.", "มิ.ย.", "ก.ค.", "ส.ค.", "ก.ย.", "ต.ค.", "พ.ย.", "ธ.ค."
    ];
    var d = new Date(date)

    var day = d.getDate();
    var monthIndex = d.getMonth();
    var year = d.getFullYear() + 543;

    return day + ' ' + monthNames[monthIndex] + ' ' + year;
  }

  function diffDate(dateTo, dateFrom) {
    var oneDay = 24 * 60 * 60 * 1000;
    return Math.round(Math.abs((new Date(dateTo).getTime() - new Date(dateFrom).getTime()) / (oneDay)));
  }

  function checkStatusDate(item) {

    if (item.projectStatus === 'active') {
      return diffDate(item.dateTo, Date.now())
    } else if (item.projectStatus === 'pending') {
      return diffDate(item.dateTo, item.dateFrom)
    } else {
      return "-"
    }
  }

  $("#load-more").click(function () {
    page++
    $.get(`/load_more?page=${page}`, function (json) {
      console.log(json);
      $.each(json, function (index, data) {
        $("#project-card").append(
          `
            <section class="col-lg-4 col-md-6 col-sm-6 col-xs-12 pb-5">
              <section class="card">
                <div class="card-body">
                  <section class="card-title" title="ข้อความเต็ม">
                    <span class="text-large text-dark">
                      ${data.code}
                    </span>
                    <span class="text-large">
                      ${data.name}
                    </span>
                  </section>

                  <section>
                    <img class="card-img-top" src="${data.images1}" alt="project image">
                  </section>

                  <section class="project-progress">
                    <div class="text-between text-small">
                      <span>เป้าหมาย</span>
                      <span>ระยะเวลาในการระดมทุน</span>
                    </div>
                    <div class="text-between">
                      <h2 class="text-large">${currencyFormat(data.budget)}</h2>
                      <span class="text-normal">01/02/62 - 01/06/62</span>
                    </div>
                    <div class="progress">
                      <div class="progress-bar bg-warning" role="progressbar" style="width: <%= calculate_percent(project.donation,project.budget)  %>%" aria-valuenow="<%= calculate_percent(project.donation,project.budget)  %>" aria-valuemin="0" aria-valuemax="100">75%</div>
                    </div>
                    <div>
                      <span class="text-normal">เหลือเวลาอีก
                      ${checkStatusDate(data)}
                      วัน</span>
                    </div>
                  </section>

                  <section class="card-text" title="ข้อความเต็ม">
                    ${data.introduce}
                  </section>

                  <a type="button" class="btn btn-primary w-100" href="/details/${data.id}"> ร่วมบริจาค SPB${data.code} </a>

                </div>
              </section>
            </section>
          `
        );
      })
    });
  });
});