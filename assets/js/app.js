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

// Import local files
//
// Local files can be imported directly using relative paths, for example:
// import socket from "./socket"

$.ajaxSetup({ cache: true });

const tabs = document.querySelectorAll('.tab-menu > li > a');

function removeActiveTabs() {
    tabs.forEach(tab => {
        tab.classList.remove('active');
    });
}

function activeTabs(el) {
    el.classList.add('active');
}

tabs.forEach(tab => {
    tab.addEventListener('click', function (e) {

        removeActiveTabs();
        activeTabs(tab);
        // e.preventDefault();
    });
});