<%-- 
    Document   : error
    Created on : Sep 21, 2021, 2:21:14 PM
    Author     : thien
--%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core"
          prefix="c"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" href="./asset/css/error.css" />
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Error</title>
    </head>
    <body>
        <section class="centered">
            <h1>500 Server Error :(</h1>
            <div class="container">
                <span class="message" id="js-whoops"></span> <span class="message" id="js-appears"></span> <span class="message" id="js-error"></span> <span class="message" id="js-apology"></span>
                <div><span class="hidden" id="js-hidden">Message Here</span></div>
            </div>
            <h3>It looks like the reason is:</h3>
            <div class="message"><span>${errorMessage}</span></div>
            <br/>
            <div class="message"><span>Please click <a href="home">here</a> to back to home page</span></div>
        </section>
    </body>
    <script src="./asset/js/error.js"></script>
</html>
