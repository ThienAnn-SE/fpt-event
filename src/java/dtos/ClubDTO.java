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
public class ClubDTO {
    private int clubID;
    private String clubName;
    private Date createDate;
    private String clubDescription;
    private String clubEmail;
    private String clubPhoneNumber;

    public ClubDTO(int clubID, String clubName, Date createDate, String clubDescription, String clubEmail, String clubPhoneNumber) {
        this.clubID = clubID;
        this.clubName = clubName;
        this.createDate = createDate;
        this.clubDescription = clubDescription;
        this.clubEmail = clubEmail;
        this.clubPhoneNumber = clubPhoneNumber;
    }

    public ClubDTO() {
    }

    public int getClubID() {
        return clubID;
    }

    public void setClubID(int clubID) {
        this.clubID = clubID;
    }

    public String getClubName() {
        return clubName;
    }

    public void setClubName(String clubName) {
        this.clubName = clubName;
    }

    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

    public String getClubDescription() {
        return clubDescription;
    }

    public void setClubDescription(String clubDescription) {
        this.clubDescription = clubDescription;
    }

    public String getClubEmail() {
        return clubEmail;
    }

    public void setClubEmail(String clubEmail) {
        this.clubEmail = clubEmail;
    }

    public String getClubPhoneNumber() {
        return clubPhoneNumber;
    }

    public void setClubPhoneNumber(String clubPhoneNumber) {
        this.clubPhoneNumber = clubPhoneNumber;
    }
    
    
}
