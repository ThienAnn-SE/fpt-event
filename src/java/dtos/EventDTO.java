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
    private int categoryID;
    private int statusID;
    private String createDate;
    private String registerEndDate;
    private String startDate;
    private String endDate;
    private int slot;
    private String imageURL;
    private String content;
    private int ticketFee;

    public EventDTO(int eventID, String eventName, int clubID, int locationID, int catetoryID, int statusID, String createDate, String registerEndDate, String startDate, String endDate, int slot, String content, int ticketFee) {
        this.eventID = eventID;
        this.eventName = eventName;
        this.clubID = clubID;
        this.locationID = locationID;
        this.categoryID = catetoryID;
        this.statusID = statusID;
        this.createDate = createDate;
        this.registerEndDate = registerEndDate;
        this.startDate = startDate;
        this.endDate = endDate;
        this.slot = slot;
        this.content = content;
        this.ticketFee = ticketFee;
    }

    public EventDTO(int eventID, String eventName, int clubID, int locationID, int categoryID, int statusID, String createDate, String registerEndDate, String startDate, String endDate, int slot, String imageURL, String content, int ticketFee) {
        this.eventID = eventID;
        this.eventName = eventName;
        this.clubID = clubID;
        this.locationID = locationID;
        this.categoryID = categoryID;
        this.statusID = statusID;
        this.createDate = createDate;
        this.registerEndDate = registerEndDate;
        this.startDate = startDate;
        this.endDate = endDate;
        this.slot = slot;
        this.imageURL = imageURL;
        this.content = content;
        this.ticketFee = ticketFee;
    }

    public EventDTO(int eventID, String eventName, int locationID, int catetoryID, String registerEndDate, String startDate, String endDate, int slot, String imageURL, String content, int ticketFee) {
        this.eventID = eventID;
        this.eventName = eventName;
        this.locationID = locationID;
        this.categoryID = catetoryID;
        this.registerEndDate = registerEndDate;
        this.startDate = startDate;
        this.endDate = endDate;
        this.slot = slot;
        this.imageURL = imageURL;
        this.content = content;
        this.ticketFee = ticketFee;
    }

    public EventDTO(int eventID, String eventName, int locationID, int catetoryID, int statusID, String createDate, String registerEndDate, String startDate, String endDate, int slot, int ticketFee) {
        this.eventID = eventID;
        this.eventName = eventName;
        this.locationID = locationID;
        this.categoryID = catetoryID;
        this.statusID = statusID;
        this.createDate = createDate;
        this.registerEndDate = registerEndDate;
        this.startDate = startDate;
        this.endDate = endDate;
        this.slot = slot;
        this.ticketFee = ticketFee;
    }

    public EventDTO(int eventID, String eventName, int clubID, int catetoryID, int statusID, String startDate, String content, String imageURL, int slot) {
        this.eventID = eventID;
        this.eventName = eventName;
        this.clubID = clubID;
        this.categoryID = catetoryID;
        this.statusID = statusID;
        this.startDate = startDate;
        this.content = content;
        this.imageURL = imageURL;
        this.slot = slot;
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

    public int getCategoryID() {
        return categoryID;
    }

    public void setCategoryID(int categoryID) {
        this.categoryID = categoryID;
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

    public String getRegisterEndDate() {
        return registerEndDate;
    }

    public void setRegisterEndDate(String registerEndDate) {
        this.registerEndDate = registerEndDate;
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

    public String getImageURL() {
        return imageURL;
    }

    public void setImageURL(String imageURL) {
        this.imageURL = imageURL;
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
