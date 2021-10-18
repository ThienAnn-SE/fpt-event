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
public class UserDTO {

    private String email;
    private String name;
    private String dayOfBirth;
    private boolean gender;
    private String phoneNumber;
    private int role;
    private int status;

    public UserDTO(String email, int role, int status) {
        this.email = email;
        this.role = role;
        this.status = status;
    }

    public UserDTO(String email, String name, int status) {
        this.email = email;
        this.name = name;
        this.status = status;
    }

    public UserDTO(String email, String name, String dayOfBirth, boolean gender, String phoneNumber, int role, int status) {
        this.email = email;
        this.name = name;
        this.dayOfBirth = dayOfBirth;
        this.gender = gender;
        this.phoneNumber = phoneNumber;
        this.role = role;
        this.status = status;
    }

    public UserDTO() {
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

    public String getDayOfBirth() {
        return dayOfBirth;
    }

    public void setDayOfBirth(String dayOfBirth) {
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
