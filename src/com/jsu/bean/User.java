package com.jsu.bean;

import java.util.Date;

public class User {
    private Integer id;
    private String email;
    private String password;
    private Date registerDate;
    private String name;
    private String phoneNumber;
    private Date birthday;
    private String pic;

    public User(){}
    public User(Integer id, String email, String password, Date registerDate) {
        this.id = id;
        this.email = email;
        this.password = password;
        this.registerDate = registerDate;
    }


    public User(Integer id, String email, String password, Date registerDate, String name, String phoneNumber, Date birthday) {
        this.id = id;
        this.email = email;
        this.password = password;
        this.registerDate = registerDate;
        this.name = name;
        this.phoneNumber = phoneNumber;
        this.birthday = birthday;
    }

    public User(Integer id, String email, String password, Date registerDate, String name, String phoneNumber, Date birthday, String pic) {
        this.id = id;
        this.email = email;
        this.password = password;
        this.registerDate = registerDate;
        this.name = name;
        this.phoneNumber = phoneNumber;
        this.birthday = birthday;
        this.pic = pic;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public Date getRegisterDate() {
        return registerDate;
    }

    public void setRegisterDate(Date registerDate) {
        this.registerDate = registerDate;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public Date getBirthday() {
        return birthday;
    }

    public void setBirthday(Date birthday) {
        this.birthday = birthday;
    }

    public String getPic() {
        return pic;
    }

    public void setPic(String pic) {
        this.pic = pic;
    }

    @Override
    public String toString() {
        return "User{" +
                "id=" + id +
                ", email='" + email + '\'' +
                ", password='" + password + '\'' +
                ", registerDate=" + registerDate +
                ", name='" + name + '\'' +
                ", phoneNumber='" + phoneNumber + '\'' +
                ", birthday=" + birthday +
                ", pic='" + pic + '\'' +
                '}';
    }
}