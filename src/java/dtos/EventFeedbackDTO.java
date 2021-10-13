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
public class EventFeedbackDTO {
    private int registerID;
    private int vote;
    private String feedback;

    public EventFeedbackDTO(int registerID, int vote, String feedback) {
        this.registerID = registerID;
        this.vote = vote;
        this.feedback = feedback;
    }

    public EventFeedbackDTO() {
    }

    public int getRegisterID() {
        return registerID;
    }

    public void setRegisterID(int registerID) {
        this.registerID = registerID;
    }

    public int getVote() {
        return vote;
    }

    public void setVote(int vote) {
        this.vote = vote;
    }

    public String getFeedback() {
        return feedback;
    }

    public void setFeedback(String feedback) {
        this.feedback = feedback;
    }
    
    
}
