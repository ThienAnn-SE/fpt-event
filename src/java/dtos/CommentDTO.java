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
public class CommentDTO {

    private int commentID;
    private int eventID;
    private String email;
    private String avatar;
    private String comment;
    private String postDate;
    private int commentNum;

    public CommentDTO() {
    }

    public CommentDTO(int eventID, String email, String avatar, String comment, String postDate) {
        this.eventID = eventID;
        this.email = email;
        this.avatar = avatar;
        this.comment = comment;
        this.postDate = postDate;
    }

    public CommentDTO(int commentID, int eventID, String email, String avatar, String comment, String postDate) {
        this.commentID = commentID;
        this.eventID = eventID;
        this.email = email;
        this.avatar = avatar;
        this.comment = comment;
        this.postDate = postDate;
    }

    public CommentDTO(int eventID, int commentNum) {
        this.eventID = eventID;
        this.commentNum = commentNum;
    }

    public int getCommentID() {
        return commentID;
    }

    public void setCommentID(int commentID) {
        this.commentID = commentID;
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

    public String getAvatar() {
        return avatar;
    }

    public void setAvatar(String avatar) {
        this.avatar = avatar;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public String getPostDate() {
        return postDate;
    }

    public void setPostDate(String postDate) {
        this.postDate = postDate;
    }

    public int getCommentNum() {
        return commentNum;
    }

    public void setCommentNum(int commentNum) {
        this.commentNum = commentNum;
    }

}
