/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dtos;

/**
 *
 * @author thien
 */
public class BanRequestDTO {

    private int requestID;
    private int clubID;
    private String userEmail;
    private String sendDate;
    private String endDate;
    private boolean requestStatus;

    public BanRequestDTO(int requestID, int clubID, String userMail, String sendDate, String endDate, boolean requestStatus) {
        this.requestID = requestID;
        this.clubID = clubID;
        this.userEmail = userMail;
        this.sendDate = sendDate;
        this.endDate = endDate;
        this.requestStatus = requestStatus;
    }

    public BanRequestDTO(int requestID, int clubID, String userMail, String sendDate, boolean requestStatus) {
        this.requestID = requestID;
        this.clubID = clubID;
        this.userEmail = userMail;
        this.sendDate = sendDate;
        this.requestStatus = requestStatus;
    }

    public BanRequestDTO(int clubID, String userMail, String sendDate) {
        this.clubID = clubID;
        this.userEmail = userMail;
        this.sendDate = sendDate;
    }

    public BanRequestDTO() {
    }

    public int getRequestID() {
        return requestID;
    }

    public void setRequestID(int requestID) {
        this.requestID = requestID;
    }

    public int getClubID() {
        return clubID;
    }

    public void setClubID(int clubID) {
        this.clubID = clubID;
    }

    public String getUserEmail() {
        return userEmail;
    }

    public void setUserEmail(String userEmail) {
        this.userEmail = userEmail;
    }

    public String getSendDate() {
        return sendDate;
    }

    public void setSendDate(String sendDate) {
        this.sendDate = sendDate;
    }

    public String getEndDate() {
        return endDate;
    }

    public void setEndDate(String endDate) {
        this.endDate = endDate;
    }

    public boolean isRequestStatus() {
        return requestStatus;
    }

    public void setRequestStatus(boolean requestStatus) {
        this.requestStatus = requestStatus;
    }

}
