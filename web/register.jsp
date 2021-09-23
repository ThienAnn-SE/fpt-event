<%-- 
    Document   : register
    Created on : Sep 23, 2021, 8:17:17 PM
    Author     : thien
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <form action="RegisterController" method="POST">
            Email: <input type="email" name="email" id="user-email"><br>
            Name: <input type="text" name="name" id="user-name"><br>
            Day of Birth: <input type="date" name="dayOfBirth" id="user-dayOfBirth"><br>
            <label for="gender1"> Male </label>
            <input type="checkbox" id="user-gender" name="gender" value="1">
            <label for="gender2"> Female </label>
            <input type="checkbox" id="gender2" name="gender" value="0"><br>
            <label for="phone">Enter your phone number:</label>
            <input type="tel" name="phoneNumber" id="user-phoneNumber" pattern="0[0-9\s.-]{9,13}"><br>
            <input type="submit" value="Submit">
        </form>
    </body>
</html>
