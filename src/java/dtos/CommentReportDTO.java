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
public class CommentReportDTO {

    private int reportID;
    private int commentID;
    private String userEmail;
    private String reportedComment;
    private String sendDate;
    private String approvalDate;
    private int reportStatus;
    private int violationTimes;

    public CommentReportDTO(int reportID, int commentID, String userEmail, String reportedComment, String sendDate, int reportStatus) {
        this.reportID = reportID;
        this.commentID = commentID;
        this.userEmail = userEmail;
        this.reportedComment = reportedComment;
        this.sendDate = sendDate;
        this.reportStatus = reportStatus;
    }

    public CommentReportDTO(int reportID, int commentID, String userEmail, int reportStatus, int violationTimes) {
        this.reportID = reportID;
        this.commentID = commentID;
        this.userEmail = userEmail;
        this.reportStatus = reportStatus;
        this.violationTimes = violationTimes;
    }

    public CommentReportDTO(int commentID, String userEmail, String sendDate) {
        this.commentID = commentID;
        this.userEmail = userEmail;
        this.sendDate = sendDate;
    }

    public CommentReportDTO(String userEmail, int violationTimes) {
        this.userEmail = userEmail;
        this.violationTimes = violationTimes;
    }

    public CommentReportDTO() {
    }

    public int getReportID() {
        return reportID;
    }

    public void setReportID(int reportID) {
        this.reportID = reportID;
    }

    public int getCommentID() {
        return commentID;
    }

    public void setCommentID(int commentID) {
        this.commentID = commentID;
    }

    public String getUserEmail() {
        return userEmail;
    }

    public void setUserEmail(String userEmail) {
        this.userEmail = userEmail;
    }

    public String getReportedComment() {
        return reportedComment;
    }

    public void setReportedComment(String reportedComment) {
        this.reportedComment = reportedComment;
    }

    public String getSendDate() {
        return sendDate;
    }

    public void setSendDate(String sendDate) {
        this.sendDate = sendDate;
    }

    public String getApprovalDate() {
        return approvalDate;
    }

    public void setApprovalDate(String approvalDate) {
        this.approvalDate = approvalDate;
    }

    public int isReportStatus() {
        return reportStatus;
    }

    public void setReportStatus(int reportStatus) {
        this.reportStatus = reportStatus;
    }

    public int getViolationTimes() {
        return violationTimes;
    }

    public void setViolationTimes(int violationTimes) {
        this.violationTimes = violationTimes;
    }
}
