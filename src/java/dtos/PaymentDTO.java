/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dtos;

import java.util.Date;

/**
 *
 * @author thien
 */
public class PaymentDTO {
    private String paymentID;
    private int registerID;
    private String statusDescription;
    private Date paymentDate;
    private int paymentTotal;

    public PaymentDTO(int registerID, String statusDescription, Date paymentDate, int paymentTotal) {
        this.registerID = registerID;
        this.statusDescription = statusDescription;
        this.paymentDate = paymentDate;
        this.paymentTotal = paymentTotal;
    }

    public PaymentDTO() {
    }

    public String getPaymentID() {
        return paymentID;
    }

    public void setPaymentID(String paymentID) {
        this.paymentID = paymentID;
    }

    public int getRegisterID() {
        return registerID;
    }

    public void setRegisterID(int registerID) {
        this.registerID = registerID;
    }

    public String getStatusDescription() {
        return statusDescription;
    }

    public void setStatusDescription(String statusDescription) {
        this.statusDescription = statusDescription;
    }

    public Date getPaymentDate() {
        return paymentDate;
    }

    public void setPaymentDate(Date paymentDate) {
        this.paymentDate = paymentDate;
    }

    public int getPaymentTotal() {
        return paymentTotal;
    }

    public void setPaymentTotal(int paymentTotal) {
        this.paymentTotal = paymentTotal;
    }
    
    
}
