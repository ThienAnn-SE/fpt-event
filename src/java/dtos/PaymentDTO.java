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
    private String paymentDescription;
    private String statusDescription;
    private String paymentMethod;
    private String paymentDate;
    private double paymentTotal;

    public PaymentDTO(int registerID, String paymentDescription, String statusDescription, String paymentMethod, String paymentDate, double paymentTotal) {
        this.registerID = registerID;
        this.paymentDescription = paymentDescription;
        this.statusDescription = statusDescription;
        this.paymentMethod = paymentMethod;
        this.paymentDate = paymentDate;
        this.paymentTotal = paymentTotal;
    }

    public PaymentDTO(String paymentDescription, String statusDescription, String paymentMethod, String paymentDate, double paymentTotal) {
        this.paymentDescription = paymentDescription;
        this.statusDescription = statusDescription;
        this.paymentMethod = paymentMethod;
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

    public String getPaymentDescription() {
        return paymentDescription;
    }

    public void setPaymentDescription(String paymentDescription) {
        this.paymentDescription = paymentDescription;
    }

    public String getStatusDescription() {
        return statusDescription;
    }

    public void setStatusDescription(String statusDescription) {
        this.statusDescription = statusDescription;
    }

    public String getPaymentMethod() {
        return paymentMethod;
    }

    public void setPaymentMethod(String paymentMethod) {
        this.paymentMethod = paymentMethod;
    }

    public String getPaymentDate() {
        return paymentDate;
    }

    public void setPaymentDate(String paymentDate) {
        this.paymentDate = paymentDate;
    }

    public double getPaymentTotal() {
        return paymentTotal;
    }

    public void setPaymentTotal(double paymentTotal) {
        this.paymentTotal = paymentTotal;
    }

}
