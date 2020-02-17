import $ from 'jquery';
window.jQuery = $;
window.$ = $;

import 'bootstrap';

$(document).ready(function () {
  let page = 1;
  $("#load-more").click(function () {
    page++
    $.get(`/load_more?page=${page}`, function (data) {
      console.log(data);
    });
  });
});