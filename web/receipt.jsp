<%-- 
    Document   : receipt
    Created on : Oct 2, 2021, 4:38:25 AM
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
        <div align="center">
            <h1>Payment Done. Please click the button to back the home page</h1>
            <br/>
            <h2>Receipt Details:</h2>
            <table>
                <tr>
                    <td><b>Payer:</b></td>
                    <td>${payer.firstName}</td>      
                </tr>
                <tr>
                    <td><b>Email: </b></td>
                    <td>${payer.email}</td>      
                </tr>
                <tr>
                    <td><b>Phone number:</b></td>
                    <td>${payer.phone}</td>      
                </tr>
                <tr>
                    <td><b>Description:</b></td>
                    <td>${transaction.description}</td>
                </tr>
                <tr>
                    <td><b>Subtotal:</b></td>
                    <td>${transaction.amount.details.subtotal} VND</td>
                </tr>
                <tr>
                    <td><b>Total:</b></td>
                    <td>${transaction.amount.total} VND</td>
                </tr>                    
            </table>
                
        </div>
    </body>
</html>
