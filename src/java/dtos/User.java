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
public class User {
    private String email;
    private String name;
    private Date dayOfBirth;
    private boolean gender;
    private String phoneNumber;
    private int role;
    private int status;

    public User(String email, String name, Date dayOfBirth, boolean gender, String phoneNumber, int role, int status) {
        this.email = email;
        this.name = name;
        this.dayOfBirth = dayOfBirth;
        this.gender = gender;
        this.phoneNumber = phoneNumber;
        this.role = role;
        this.status = status;
    }

    public User() {
    }
    

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Date getDayOfBirth() {
        return dayOfBirth;
    }

    public void setDayOfBirth(Date dayOfBirth) {
        this.dayOfBirth = dayOfBirth;
    }

    public boolean isGender() {
        return gender;
    }

    public void setGender(boolean gender) {
        this.gender = gender;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public int getRole() {
        return role;
    }

    public void setRole(int role) {
        this.role = role;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }
    
    
}
