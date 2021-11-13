var search = document.querySelector(".search");
var clear = document.querySelectorAll(".clear");
var mobileHeader = document.querySelector(".mobile-header");
var overlay = document.querySelector(".header-overlay");

    document.querySelector(".mobile-btn").addEventListener("click", function () {
      mobileHeader.style.transform = "translateX(0)";
      overlay.style.display = "block";
    });
    document.querySelector(".mobile-header-close").addEventListener("click", function () {
      mobileHeader.style.transform = "translateX(100%)";
      overlay.style.display = "none";
    });

      //search by name
      document.querySelector(".search-icon").addEventListener("click", function () {
        search.classList.toggle("active");
        if (document.querySelector(".search.active"))
          clear[0].style.display = "block";
        else clear[0].style.display = "none";
      });
      clear.forEach((item) => {
        item.addEventListener("click", function () {
          document.querySelectorAll(".search-input").forEach((item) => item.value = "")
        });
      });
