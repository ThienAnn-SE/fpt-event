
<%@taglib uri="http://java.sun.com/jsp/jstl/core"
          prefix="c"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Login Page</title>
        <link rel="stylesheet" href="./asset/css/reset.css" />
        <link rel="stylesheet" href="./asset/css/LoginForm.css" />
    </head>
    <body>
        <div class="container">
            <div class="circle"></div>
            <div class="content">
                <div class="box">
                    <div class="square" style="--i: 0"></div>
                    <div class="square" style="--i: 1"></div>
                    <div class="square" style="--i: 2"></div>
                    <div class="square" style="--i: 3"></div>
                    <div class="square" style="--i: 4"></div>
                    <div class="login-form">
                        <div class="form">
                            <h2>Login Form</h2>
                            <form>
                                <div class="inputBox invalid">
                                    <input type="email" placeholder=" " />
                                    <label for="email">Email</label>
                                    <c:if test="${not empty errorMessage}">
                                        <img src="./asset/img/invalid.png" />
                                        <span class="invalid">Invalid email</span>
                                    </c:if>
                                </div>
                                <div class="inputBox">
                                    <input type="password" placeholder=" " />
                                    <label for="password">Password</label>
                                    <c:if test="${not empty errorMessage}">
                                        <img src="./asset/img/invalid.png" />
                                        <span class="invalid"></span>
                                    </c:if>
                                </div>
                                <div class="inputBox">
                                    <input type="submit" value="Login" />
                                </div>
              s                  <a class="google" href="https://accounts.google.com/o/oauth2/auth?scope=email&redirect_uri=http://localhost:8080/fpt-event/GoogleLoginController&response_type=code&client_id=469898869226-81mot377rp6tcd9d4ka8oun0o62bjvao.apps.googleusercontent.com&approval_prompt=force">
                                    <img src="https://cdn-icons-png.flaticon.com/128/281/281764.png" />
                                    Login With Google
                                </a>
                                <span class="invalid">${requestScope.error}</span>
                            </form>
                        </div>
                    </div>
                </div>
                <div class="img">
                    <img src="./asset/img/fu.png" />
                </div>
            </div>
        </div>

        <script>

        </script>
    </body>
</html>
