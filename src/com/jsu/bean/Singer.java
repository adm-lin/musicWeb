package com.jsu.bean;

import java.sql.Blob;

public class Singer {
    private String name;
    private String introduction;
    private Blob pic;

    public Singer(String name, String introduction, Blob pic) {
        this.name = name;
        this.introduction = introduction;
        this.pic = pic;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getIntroduction() {
        return introduction;
    }

    public void setIntroduction(String introduction) {
        this.introduction = introduction;
    }

    public Blob getPic() {
        return pic;
    }

    public void setPic(Blob pic) {
        this.pic = pic;
    }

    @Override
    public String toString() {
        return "Singer{" +
                "name='" + name + '\'' +
                ", introduction='" + introduction + '\'' +
                ", pic=" + pic +
                '}';
    }
}
