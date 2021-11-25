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
        <link href="./asset/css/receipt.css" rel="stylesheet" type="text/css"/>
        <title>Receipt</title>
    </head>
    <body>
        <table class="body-wrap">
            <tbody><tr>
                    <td></td>
                    <td class="container" width="600">
                        <div class="content">
                            <table class="main" width="100%" cellpadding="0" cellspacing="0">
                                <tbody><tr>
                                        <td class="content-wrap aligncenter">
                                            <table width="100%" cellpadding="0" cellspacing="0">
                                                <tbody><tr>
                                                        <td class="content-block">
                                                            <h2>Here is your receipt for the payment</h2>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="content-block">
                                                            <table class="invoice">
                                                                <tbody><tr>
                                                                        <td>${payer.firstName}<br>${payer.email}<br>${payer.phone}</td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <table class="invoice-items" cellpadding="0" cellspacing="0">
                                                                                <tbody><tr>
                                                                                        <td>${transaction.description}</td>
                                                                                        <td class="alignright">$ ${transaction.amount.details.subtotal}</td>
                                                                                    </tr>
                                                                                    <tr class="total">
                                                                                        <td class="alignright" width="80%">Total</td>
                                                                                        <td class="alignright">$ ${transaction.amount.details.subtotal}</td>
                                                                                    </tr>
                                                                                </tbody></table>
                                                                        </td>
                                                                    </tr>
                                                                </tbody></table>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="content-block">
                                                            <a href="home">Back to homepage</a>
                                                        </td>
                                                    </tr>
                                                </tbody></table>
                                        </td>
                                    </tr>
                                </tbody></table>
                            <div class="footer">
                                <table width="100%">
                                    <tbody><tr>
                                            <td class="aligncenter content-block">Copyright &#169; 2021 SWP391 - Group 6. All Rights Reserved.</td>
                                        </tr>
                                    </tbody></table>
                            </div></div>
                    </td>
                    <td></td>
                </tr>
            </tbody>
        </table>
    </body>
</html>
