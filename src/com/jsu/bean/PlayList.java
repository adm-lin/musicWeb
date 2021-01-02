package com.jsu.bean;

import java.util.Date;

public class PlayList {
    private Integer id;
    private String title;
    private Date createDate;
    private String pic;

    public PlayList() {
    }

    public PlayList(Integer id, String title, Date createDate) {
        this.id = id;
        this.title = title;
        this.createDate = createDate;
    }

    public PlayList(String title, Date createDate) {
        this.title = title;
        this.createDate = createDate;
    }

    public PlayList(Integer id, String title, Date createDate, String pic) {
        this.id = id;
        this.title = title;
        this.createDate = createDate;
        this.pic = pic;
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

    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

    public String getPic() {
        return pic;
    }

    public void setPic(String pic) {
        this.pic = pic;
    }

    @Override
    public String toString() {
        return "PlayList{" +
                "id=" + id +
                ", title='" + title + '\'' +
                ", createDate=" + createDate +
                ", pic='" + pic + '\'' +
                '}';
    }
}
