/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package utils;

import com.paypal.api.payments.Amount;
import com.paypal.api.payments.Details;
import com.paypal.api.payments.Item;
import com.paypal.api.payments.ItemList;
import com.paypal.api.payments.Links;
import com.paypal.api.payments.Payer;
import com.paypal.api.payments.PayerInfo;
import com.paypal.api.payments.Payment;
import com.paypal.api.payments.PaymentExecution;
import com.paypal.api.payments.RedirectUrls;
import com.paypal.api.payments.Transaction;
import com.paypal.base.rest.APIContext;
import com.paypal.base.rest.PayPalRESTException;
import daos.EventDAO;
import daos.UserDAO;
import dtos.EventDTO;
import dtos.EventRegisterDTO;
import dtos.UserDTO;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import javax.naming.NamingException;

/**
 *
 * @author thien
 */
public class PaymentServices {

    private static final String CLIENT_ID = "AZ5Y6cXhpMxPsZBlae6iMOAAJpuqyds0b61Oryh-to0pw0AtK4Dz6Nxi8uVvwH2j-46muL9kXtfXM2ta";
    private static final String CLIENT_SECRET = "EOfBAMujFoQUmbWl2LMAwdG8fqvV3HKDW-6mrcoh_t1EfXARFOoQ7pTJ8IPaTTJieQzPmG4-IM4-Y-po";
    private static final String MODE = "sandbox";

    public String authorizePayment(EventRegisterDTO eventRegister) throws PayPalRESTException, NamingException, SQLException {
        Payer payer = getPayerInformation(eventRegister);
        RedirectUrls redirectUrls = getRedirectURLs();
        List<Transaction> listTransaction = getTransactionInformation(eventRegister);

        Payment requestPayment = new Payment();
        requestPayment.setTransactions(listTransaction);
        requestPayment.setRedirectUrls(redirectUrls);
        requestPayment.setPayer(payer);
        requestPayment.setIntent("authorize");

        APIContext apiContext = new APIContext(CLIENT_ID, CLIENT_SECRET, MODE);

        Payment approvedPayment = requestPayment.create(apiContext);

        return getApprovalLink(approvedPayment);
    }

    private Payer getPayerInformation(EventRegisterDTO eventRegister) throws SQLException, NamingException {
        Payer payer = new Payer();
        payer.setPaymentMethod("paypal");

        UserDAO userDAO = new UserDAO();
        UserDTO userDTO = userDAO.getUserByEmail(eventRegister.getEmail());

        PayerInfo payerInfo = new PayerInfo();
        payerInfo.setFirstName(userDTO.getName())
                .setEmail(userDTO.getEmail());
        payer.setPayerInfo(payerInfo);
        return payer;
    }

    private RedirectUrls getRedirectURLs() {
        RedirectUrls redirectUrls = new RedirectUrls();
        redirectUrls.setCancelUrl("http://localhost:8080/fpt-event/SearchEventController");
        redirectUrls.setReturnUrl("http://localhost:8080/fpt-event/ExecutePaymentController");

        return redirectUrls;
    }

    private List<Transaction> getTransactionInformation(EventRegisterDTO eventRegister) throws NamingException, SQLException {
        EventDAO eventDAO = new EventDAO();
        EventDTO eventDTO = eventDAO.getEventByID(eventRegister.getEventID());

        double value = (double) eventDTO.getTicketFee() / 23000;
        String price = String.format("%.2f", value);

        Details details = new Details();
        details.setSubtotal(price);

        Amount amount = new Amount();
        amount.setCurrency("USD");
        amount.setTotal(price);

        Transaction transaction = new Transaction();
        transaction.setAmount(amount);
        transaction.setDescription(eventDTO.getEventName() + " Ticket");

        ItemList itemList = new ItemList();
        List<Item> items = new ArrayList<>();

        Item item = new Item();
        item.setCurrency("USD");
        item.setName(eventDTO.getEventName() + "Ticket");
        item.setPrice(price);
        item.setQuantity("1");

        items.add(item);
        itemList.setItems(items);
        transaction.setItemList(itemList);

        List<Transaction> listTransaction = new ArrayList<>();
        listTransaction.add(transaction);

        return listTransaction;
    }

    private String getApprovalLink(Payment approvedPayment) {
        List<Links> links = approvedPayment.getLinks();
        String approvalLink = null;

        for (Links link : links) {
            if (link.getRel().equalsIgnoreCase("approval_url")) {
                approvalLink = link.getHref();
                break;
            }
        }
        return approvalLink;
    }

    public Payment getPaymentDetails(String paymentId) throws PayPalRESTException {
        APIContext apiContext = new APIContext(CLIENT_ID, CLIENT_SECRET, MODE);
        return Payment.get(apiContext, paymentId);
    }

    public Payment executePayment(String paymentId, String payerId)
            throws PayPalRESTException {
        PaymentExecution paymentExecution = new PaymentExecution();
        paymentExecution.setPayerId(payerId);

        Payment payment = new Payment().setId(paymentId);

        APIContext apiContext = new APIContext(CLIENT_ID, CLIENT_SECRET, MODE);

        return payment.execute(apiContext, paymentExecution);
    }
}
