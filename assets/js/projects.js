import $ from 'jquery';
window.jQuery = $;
window.$ = $;

import 'bootstrap';

$(document).ready(function () {
  let page = 1;
  $("#load-more").click(function () {
    page++
    $.get(`/load_more?page=${page}`, function (json) {
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
                      ${data.title}
                    </span>
                  </section>

                  <section>
                    <img class="card-img-top" src="${data.img_card}" alt="project image">
                  </section>

                  <section class="project-progress">
                    <div class="text-between text-small">
                      <span>เป้าหมาย</span>
                      <span>ระยะเวลาในการระดมทุน</span>
                    </div>
                    <div class="text-between">
                      <h2 class="text-large"><%= format_number(project.pledged_goal) %></h2>
                      <span class="text-normal">01/02/62 - 01/06/62</span>
                    </div>
                    <div class="progress">
                      <div class="progress-bar bg-warning" role="progressbar" style="width: <%= calculate_percent(project.donation,project.pledged_goal)  %>%" aria-valuenow="<%= calculate_percent(project.donation,project.pledged_goal)  %>" aria-valuemin="0" aria-valuemax="100">75%</div>
                    </div>
                    <div>
                      <span class="text-normal">เหลือเวลาอีก
                      <%= Kernel.trunc((((DateTime.diff(project.end_date, DateTime.utc_now)/60)/60)/24)) %>
                      วัน</span>
                    </div>
                  </section>

                </div>
              </section>
            </section>
          `
        );
      })
    });
  });
});