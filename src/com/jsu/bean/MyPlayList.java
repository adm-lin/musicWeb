package com.jsu.bean;

import java.util.Date;

public class MyPlayList {
    private Integer id;
    private String title;
    private Integer userId;
    private  String pic;
    private Date createDate;

    public MyPlayList() {
    }

    public MyPlayList(Integer id,  Integer userId,String title, String pic, Date createDate) {
        this.id = id;
        this.title = title;
        this.userId = userId;
        this.pic = pic;
        this.createDate = createDate;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public String getPic() {
        return pic;
    }

    public void setPic(String pic) {
        this.pic = pic;
    }

    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

    @Override
    public String toString() {
        return "MyPlayList{" +
                "id=" + id +
                ", title='" + title + '\'' +
                ", userId=" + userId +
                ", pic='" + pic + '\'' +
                ", createDate=" + createDate +
                '}';
    }
}
