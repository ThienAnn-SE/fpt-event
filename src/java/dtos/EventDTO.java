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
public class EventDTO {

    private int eventID;
    private String eventName;
    private int clubID;
    private int locationID;
    private int catetoryID;
    private int statusID;
    private String createDate;
    private String startDate;
    private String endDate;
    private int slot;
    private double avgVote;
    private String content;
    private int ticketFee;

    public EventDTO(int eventID, String eventName, int clubID, int locationID, int catetoryID, int statusID, String createDate, String startDate, String endDate, int slot, double avgVote, String content, int ticketFee) {
        this.eventID = eventID;
        this.eventName = eventName;
        this.clubID = clubID;
        this.locationID = locationID;
        this.catetoryID = catetoryID;
        this.statusID = statusID;
        this.createDate = createDate;
        this.startDate = startDate;
        this.endDate = endDate;
        this.slot = slot;
        this.avgVote = avgVote;
        this.content = content;
        this.ticketFee = ticketFee;
    }

    public EventDTO(int eventID, String createDate, String startDate, String endDate) {
        this.eventID = eventID;
        this.createDate = createDate;
        this.startDate = startDate;
        this.endDate = endDate;
    }

    public EventDTO() {
    }

    public int getEventID() {
        return eventID;
    }

    public void setEventID(int eventID) {
        this.eventID = eventID;
    }

    public String getEventName() {
        return eventName;
    }

    public void setEventName(String eventName) {
        this.eventName = eventName;
    }

    public int getClubID() {
        return clubID;
    }

    public void setClubID(int clubID) {
        this.clubID = clubID;
    }

    public int getLocationID() {
        return locationID;
    }

    public void setLocationID(int locationID) {
        this.locationID = locationID;
    }

    public int getCatetoryID() {
        return catetoryID;
    }

    public void setCatetoryID(int catetoryID) {
        this.catetoryID = catetoryID;
    }

    public int getStatusID() {
        return statusID;
    }

    public void setStatusID(int statusID) {
        this.statusID = statusID;
    }

    public String getCreateDate() {
        return createDate;
    }

    public void setCreateDate(String createDate) {
        this.createDate = createDate;
    }

    public String getStartDate() {
        return startDate;
    }

    public void setStartDate(String startDate) {
        this.startDate = startDate;
    }

    public String getEndDate() {
        return endDate;
    }

    public void setEndDate(String endDate) {
        this.endDate = endDate;
    }

    public int getSlot() {
        return slot;
    }

    public void setSlot(int slot) {
        this.slot = slot;
    }

    public double getAvgVote() {
        return avgVote;
    }

    public void setAvgVote(double avgVote) {
        this.avgVote = avgVote;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public int getTicketFee() {
        return ticketFee;
    }

    public void setTicketFee(int ticketFee) {
        this.ticketFee = ticketFee;
    }

}
