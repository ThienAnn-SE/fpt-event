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
public class VisitorCounterDTO {

    private String logDate;
    private int visitorNumber;

    public VisitorCounterDTO(String logDate, int visitorNumber) {
        this.logDate = logDate;
        this.visitorNumber = visitorNumber;
    }

    public VisitorCounterDTO() {
    }

    public String getLogDate() {
        return logDate;
    }

    public void setLogDate(String logDate) {
        this.logDate = logDate;
    }

    public int getVisitorNumber() {
        return visitorNumber;
    }

    public void setVisitorNumber(int visitorNumber) {
        this.visitorNumber = visitorNumber;
    }

}
