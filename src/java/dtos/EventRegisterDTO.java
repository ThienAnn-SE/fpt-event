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
public class EventRegisterDTO {
    private int registerID;
    private int eventID;
    private String email;
    private Date registerDate;

    public EventRegisterDTO() {
    }

    public EventRegisterDTO(int registerID, int eventID, String email, Date registerDate) {
        this.registerID = registerID;
        this.eventID = eventID;
        this.email = email;
        this.registerDate = registerDate;
    }

    public int getRegisterID() {
        return registerID;
    }

    public void setRegisterID(int registerID) {
        this.registerID = registerID;
    }

    public int getEventID() {
        return eventID;
    }

    public void setEventID(int eventID) {
        this.eventID = eventID;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public Date getRegisterDate() {
        return registerDate;
    }

    public void setRegisterDate(Date registerDate) {
        this.registerDate = registerDate;
    }
    
    
}
