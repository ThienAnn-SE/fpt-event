var search = document.querySelector(".search");
      var icon = document.querySelector(".search-icon");
      var clear = document.querySelector(".clear");
      var theme = document.querySelector(".theme-switch");
      var body = document.querySelector("body");

      //search by name
      icon.addEventListener("click", function () {
        search.classList.toggle("active");
        if (document.querySelector(".search.active"))
          clear.style.display = "block";
        else clear.style.display = "none";
      });
      clear.addEventListener("click", function () {
        document.getElementById("search").value = "";
      });
      
//theme
theme.addEventListener("click", function () {
    body.classList.toggle("dark");
    if (document.querySelector(".dark"))
      theme.innerHTML = '<i class="fas fa-sun"></i>';
    else theme.innerHTML = '<i class="fal fa-moon"></i>';
  });
