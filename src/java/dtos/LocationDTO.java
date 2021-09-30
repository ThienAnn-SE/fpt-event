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
public class LocationDTO {
    private int locationID;
    private String locationName;
    private int locationCapacity;

    public LocationDTO(int locationID, String locationName, int locationCapacity) {
        this.locationID = locationID;
        this.locationName = locationName;
        this.locationCapacity = locationCapacity;
    }

    public LocationDTO() {
    }

    
    public int getLocationID() {
        return locationID;
    }

    public void setLocationID(int locationID) {
        this.locationID = locationID;
    }

    public String getLocationName() {
        return locationName;
    }

    public void setLocationName(String locationName) {
        this.locationName = locationName;
    }

    public int getLocationCapacity() {
        return locationCapacity;
    }

    public void setLocationCapacity(int locationCapacity) {
        this.locationCapacity = locationCapacity;
    }
    
    
}
