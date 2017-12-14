const Router = require("./router.js");

document.addEventListener("DOMContentLoaded", function(event) {
  let sidebarEls = event.target.querySelectorAll(".sidebar-nav li");
  sidebarEls.forEach( (el) => {
    el.addEventListener("click", () => {
      window.location.hash = el.innerText.toLowerCase();
      console.log(window.location.hash);
    });
  });
});