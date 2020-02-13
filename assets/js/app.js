// We need to import the CSS so that webpack will load it.
// The MiniCssExtractPlugin is used to separate it out into
// its own CSS file.
import 'bootstrap';
import css from "../css/app.sass"

// webpack automatically bundles all modules in your
// entry points. Those entry points can be configured
// in "webpack.config.js".
//
// Import dependencies
//
import "phoenix_html"
import {Socket} from "phoenix"
import LiveSocket from "phoenix_live_view"
let csrfToken = document.querySelector("meta[name='csrf-token']").getAttribute("content");
let liveSocket = new LiveSocket("/live", Socket, {params: {_csrf_token: csrfToken}})
liveSocket.connect()

// Import local files
//
// Local files can be imported directly using relative paths, for example:
// import socket from "./socket"

$.ajaxSetup({ cache: true });

$('#sidebarCollapse').on('click', function (e) {
    $('#sidebar').toggleClass('active');
    $('.overlay').toggleClass('active');
    e.stopPropagation();
});
$(document).click(function (e) {
    if (e.target.id !== "search-box") {
        $('#sidebar').removeClass('active');
        $('.overlay').removeClass('active');
    }
    e.stopPropagation();
});

// const tabs = document.querySelectorAll('.tab-menu > li > a');

// function removeActiveTabs() {
//     tabs.forEach(tab => {
//         tab.classList.remove('active');
//     });
// }

// function activeTabs(el) {
//     el.classList.add('active');
// }

// tabs.forEach(tab => {
//     tab.addEventListener('click', function (e) {

//         removeActiveTabs();
//         activeTabs(tab);
//         // e.preventDefault();
//     });
// });