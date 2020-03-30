import $ from 'jquery'
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
  console.log(id, title)
  console.log(src);
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