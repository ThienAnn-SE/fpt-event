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
public class CatetoryDTO {
    private int catetoryID;
    private String catetoryName;

    public CatetoryDTO(int catetoryID, String catetoryName) {
        this.catetoryID = catetoryID;
        this.catetoryName = catetoryName;
    }

    public CatetoryDTO() {
    }

    public int getCatetoryID() {
        return catetoryID;
    }

    public void setCatetoryID(int catetoryID) {
        this.catetoryID = catetoryID;
    }

    public String getCatetoryName() {
        return catetoryName;
    }

    public void setCatetoryName(String catetoryName) {
        this.catetoryName = catetoryName;
    }
    
    
}
