<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Home page</title>
    <link rel="stylesheet" href="./asset/css/reset.css" />
    <link rel="stylesheet" href="./asset/css/homePage.css" />
    <link
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/css/bootstrap.min.css"
      rel="stylesheet"
      integrity="sha384-F3w7mX95PdgyTmZZMECAngseQB83DfGTowi0iMjiWaeVhAn4FJkqJByhZMI3AhiU"
      crossorigin="anonymous"
    />
    <link
      rel="stylesheet"
      href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css"
      integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p"
      crossorigin="anonymous"
    />
  </head>
  <body>
    <header>
      <nav class="navbar navbar-expand-lg">
        <div class="navbar-header container-fluid fixed-top">
          <a class="navbar-brand" href="#">
            <img class="nav logo" src="./asset/img/fu.png" />
          </a>
          <button class="navbar-toggler">
            <i id="toggle" class="fas fa-bars"></i>
          </button>
          <div class="collapse navbar-collapse">
            <div class="navbar-nav">
              <a class="item nav-link active" href="#">home</a>
              <a class="item nav-link" href="#">event</a>
              <a class="item nav-link" href="#">club</a>
              <a class="item nav-link" href="ViewUserController">view profile</a>
              <a class="nav-link" href="https://accounts.google.com/o/oauth2/auth?scope=email&redirect_uri=http://localhost:8080/fpt-event/GoogleLoginController&response_type=code&client_id=469898869226-81mot377rp6tcd9d4ka8oun0o62bjvao.apps.googleusercontent.com&approval_prompt=force">
                <button class="button">
                  <i class="fab fa-google"></i>
                   Login
                </button>
              </a>
            </div>
          </div>
          <div class="theme-switch">
            <i class="far fa-moon"></i>
          </div>
          <div class="search">
            <div class="search-icon">
              <i class="far fa-search"></i>
            </div>
            <div class="search-input">
              <input id="search" type="text" placeholder="Search" />
            </div>
            <span class="clear"><i class="fal fa-times"></i></span>
          </div>
        </div>
      </nav>
    </header>
    <div class="banner">
      <img src="./asset/img/event.jpg" />
      <div class="content">
        <h1>event name</h1>
        <p>location - date begin - date end</p>
        <button>Read More</button>
      </div>
      <div class="countdown">
        <h2 id="hour">00</h2>
        <h2 class="dot">:</h2>
        <h2 id="minute">00</h2>
        <h2 class="dot">:</h2>
        <h2 id="second">00</h2>
      </div>
    </div>

    <div class="main">
      <div class="side-bar">
        <ul class="navbar-nav">
          <li class="nav-item">
            <div class="title">
              <i class="fad fa-list"></i>
              category
              <i class="far fa-chevron-down"></i>
            </div>
            <ul class="sub-menu">
              <li><a href="#">Seminar</a></li>
              <li><a href="#">Entertainment Event</a></li>
              <li><a href="#">Learning Event</a></li>
            </ul>
          </li>
          <li class="nav-item">
            <div class="title">
              <i class="fal fa-money-bill-wave"></i>
              search by price
            </div>
            <div class="price">
              <form action="#">
                <div class="value">
                  <span id="range1">0</span>
                  <span>-</span>
                  <span id="range2">500000</span>
                </div>
                <div class="range">
                  <div class="slider"></div>
                  <input type="range" min="0" max="500000" step="1000" value="0" id="slider1" />
                  <input type="range" min="0" max="500000" step="1000" value="500000" id="slider2" />
                </div>

                <div class="min">
                  <span class="prev"></span>
                  <input type="number" value="0" />
                  <span class="next"></span>
                </div>

                <div class="max">
                  <span class="prev"></span>
                  <input type="number" value="500000" />
                  <span class="next"></span>
                </div>
              </form>
            </div>
          </li>
          <li class="nav-item">
            <div class="title">
              <i class="fal fa-calendar-week"></i>
              search by date
            </div>
            <div class="date">
                <input type="date" id="start-date"/>
                <input type="date" id="end-date"/>
            </div>
          </li>
        </ul>
      </div>

      <div class="container">
        <div class="title">
          <i class="far fa-calendar-star"></i>
          <h2>events are upcoming</h2>
        </div>
        <div class="row">
          <a href="#" class="col-md-4">
            <div class="event">
              <div class="event-img">
                <img src="./asset/img/event.png" />
              </div>
              <div class="event-description">
                <h2>event name</h2>
                <p>
                  Lorem, ipsum dolor sit amet consectetur adipisicing elit. In
                  at a, aperiam exercitationem magni deserunt eum culpa
                  architecto porro aliquam assumenda, doloribus quaerat
                  perspiciatis est blanditiis, repellendus distinctio minima
                  voluptates?
                </p>
              </div>
            </div>
          </a>

          <a href="#" class="col-md-4">
            <div class="event">
              <div class="event-img">
                <img src="./asset/img/event.png" />
              </div>
              <div class="event-description">
                <h2>event name</h2>
                <p>
                  Lorem, ipsum dolor sit amet consectetur adipisicing elit. In
                  at a, aperiam exercitationem magni deserunt eum culpa
                  architecto porro aliquam assumenda, doloribus quaerat
                  perspiciatis est blanditiis, repellendus distinctio minima
                  voluptates?
                </p>
              </div>
            </div>
          </a>

          <a href="#" class="col-md-4">
            <div class="event">
              <div class="event-img">
                <img src="./asset/img/event.png" />
              </div>
              <div class="event-description">
                <h2>event name</h2>
                <p>
                  Lorem, ipsum dolor sit amet consectetur adipisicing elit. In
                  at a, aperiam exercitationem magni deserunt eum culpa
                  architecto porro aliquam assumenda, doloribus quaerat
                  perspiciatis est blanditiis, repellendus distinctio minima
                  voluptates?
                </p>
              </div>
            </div>
          </a>
        </div>
        <div class="read-more">
          <a href="#">Continue to reading ... </a>
        </div>
      </div>
    </div>

    <script
      src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/js/bootstrap.bundle.min.js"
      integrity="sha384-/bQdsTh/da6pkI1MST/rWKFNjaCP5gBSY4sEBT38Q/9RBh9AH40zEOg7Hlq2THRZ"
      crossorigin="anonymous"
    ></script>
    <script>
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

      //search by price 
      var prevs = document.querySelectorAll(".prev");
      var nexts = document.querySelectorAll(".next");
      var numbers = document.querySelectorAll('input[type="number"]');
      var range1 = document.getElementById("range1");
      var range2 = document.getElementById("range2");
      var slider1 = document.getElementById("slider1");
      var slider2 = document.getElementById("slider2");
      for (pre of prevs) {
        pre.addEventListener("click", function () {
        var price = this.parentElement.classList;
        if (price.value == "min") {
          if (numbers[0].value > 0) {
            numbers[0].value = parseInt(numbers[0].value) - 1000;
            slider1.value = numbers[0].value;
            range1.innerHTML = slider1.value;
          }
        } else if (price.value == "max") {
          if (numbers[1].value > 0) {
            numbers[1].value = parseInt(numbers[1].value) - 1000;
            slider2.value = numbers[1].value;
            range2.innerHTML = slider2.value;
          }
        } 
       });
      }
      for (next of nexts) {
        next.addEventListener("click", function () {
        var price = this.parentElement.classList;
        if (price.value == "min") {
          if (numbers[0].value < 500000) {
            numbers[0].value = parseInt(numbers[0].value) + 1000;
            slider1.value = numbers[0].value;
            range1.innerHTML = slider1.value;
          }
        } else if (price.value == "max") {
          if (numbers[1].value < 500000) {
            numbers[1].value = parseInt(numbers[1].value) + 1000;
            slider2.value = numbers[1].value;
            range2.innerHTML = slider2.value;
          }
        } 
       });
      }
      numbers[0].addEventListener("input", function() {
        slider1.value = numbers[0].value;
        range1.innerHTML = slider1.value;
      });
      numbers[1].addEventListener("input", function() {
        slider2.value = numbers[1].value;
        range2.innerHTML = slider2.value;
      });
      slider1.addEventListener("input", function() {
        numbers[0].value = slider1.value;
        range1.innerHTML = slider1.value;
      });
      slider2.addEventListener("input", function() {
        numbers[1].value = slider2.value;
        range2.innerHTML = slider2.value;
      });

      var countDate = new Date('Nov 30, 2021 00:00:00').getTime();
      
      function countDown() {
        var now = new Date().getTime();
        var distance = countDate - now;
        var day = Math.floor(distance / (1000 * 60 * 60 * 24));
        var hour = Math.floor((distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
        var minute = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
        var second = Math.floor((distance % (1000 * 60)) / 1000);

        if (day > 0) {
          hour = day * 24 + hour;
        }
        document.getElementById('hour').innerHTML = hour < 10 ? '0' + hour : hour;
        document.getElementById('minute').innerHTML = minute < 10 ? '0' + minute : minute;
        document.getElementById('second').innerHTML = second < 10 ? '0' + second : second;
      }
      setInterval(function(){
        countDown();
      }, 1000);
    </script>
  </body>
</html>
