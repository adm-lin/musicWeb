package com.jsu.bean;

import java.util.Date;

public class Comment {
    private Integer id;
    private Integer userId;
    private Integer playListsId;
    private String content;
    private Date commentTime;
    private String pic;
    private String userName;

    public Comment() {
    }

    public Comment(Integer id, Integer userId, Integer playListsId, String content, Date commentTime) {
        this.id = id;
        this.userId = userId;
        this.playListsId = playListsId;
        this.content = content;
        this.commentTime = commentTime;
    }

    public Comment(Integer id, Integer userId, Integer playListsId, String content, Date commentTime, String pic) {
        this.id = id;
        this.userId = userId;
        this.playListsId = playListsId;
        this.content = content;
        this.commentTime = commentTime;
        this.pic = pic;
    }

    public Comment(Integer id, Integer userId, Integer playListsId, String content, Date commentTime, String pic, String userName) {
        this.id = id;
        this.userId = userId;
        this.playListsId = playListsId;
        this.content = content;
        this.commentTime = commentTime;
        this.pic = pic;
        this.userName = userName;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public Integer getPlayListsId() {
        return playListsId;
    }

    public void setPlayListsId(Integer playListsId) {
        this.playListsId = playListsId;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Date getCommentTime() {
        return commentTime;
    }

    public void setCommentTime(Date commentTime) {
        this.commentTime = commentTime;
    }

    public String getPic() {
        return pic;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public void setPic(String pic) {
        this.pic = pic;
    }

    @Override
    public String toString() {
        return "Comment{" +
                "id=" + id +
                ", userId=" + userId +
                ", playListsId=" + playListsId +
                ", content='" + content + '\'' +
                ", commentTime=" + commentTime +
                ", pic='" + pic + '\'' +
                ", userName='" + userName + '\'' +
                '}';
    }
}
