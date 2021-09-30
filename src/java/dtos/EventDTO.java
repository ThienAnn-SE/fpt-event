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
    private String eventID;
    private String eventName;
    private int clubID;
    private int locationID;
    private int catetoryID;
    private Date createDate;
    private Date startDate;
    private Date endDate;
    private double avgVote;
    private String content;
    private boolean fee;
    private int totalFollowers;

    public EventDTO(String eventID, String eventName, int clubID, int locationID, int catetoryID, Date createDate, Date startDate, Date endDate, double avgVote, String content, boolean fee, int totalFollowers) {
        this.eventID = eventID;
        this.eventName = eventName;
        this.clubID = clubID;
        this.locationID = locationID;
        this.catetoryID = catetoryID;
        this.createDate = createDate;
        this.startDate = startDate;
        this.endDate = endDate;
        this.avgVote = avgVote;
        this.content = content;
        this.fee = fee;
        this.totalFollowers = totalFollowers;
    }

    public EventDTO() {
    }

    public String getEventID() {
        return eventID;
    }

    public void setEventID(String eventID) {
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

    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

    public Date getStartDate() {
        return startDate;
    }

    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }

    public Date getEndDate() {
        return endDate;
    }

    public void setEndDate(Date endDate) {
        this.endDate = endDate;
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

    public boolean isFee() {
        return fee;
    }

    public void setFee(boolean fee) {
        this.fee = fee;
    }

    public int getTotalFollowers() {
        return totalFollowers;
    }

    public void setTotalFollowers(int totalFollowers) {
        this.totalFollowers = totalFollowers;
    }
    
    
}
