package com.jsu.dao;

import com.jsu.bean.MyPlayList;
import com.jsu.bean.User;
import com.jsu.utils.DbUtils;
import java.util.Date;
import java.util.List;

public class UserDao {
    public User getUser(String email,String password) {
        String sql="select id,email,password,registerDate,name,pic,birthday from user where email=? and password=? ";
        User user=DbUtils.getSingleObj(User.class,sql,email,password);
        System.out.println(user);
        return  user;
    }
    public boolean isEmailExist(String email){
        String sql="select * from user where email=?";
        return DbUtils.isEmailExist(sql,email);

    }
    public boolean saveUser(User user) {
        String sql="insert into user(email,password,registerDate,name,phoneNumber,birthday,pic)" +
                "values(?,?,?,?,?,?,?)";
        return DbUtils.save(sql,user.getEmail(),user.getPassword(),user.getRegisterDate(),user.getName(),user.getPhoneNumber(),user.getBirthday(),user.getPic());
    }

    public Integer getUserCount(String sql,Object...param) {
        Integer count=DbUtils.getCount(sql,param);
        return count;
    }

    public List<User> getUserList(String sql) {
        List<User> userList=DbUtils.getList(User.class,sql);
        return  userList;
    }

    public boolean deleteUser(String email) {
        String sql="DELETE FROM user WHERE email=?";
        boolean flag=DbUtils.update(sql,email);
        return flag;
    }

    public boolean upDateUser(String email, String name, String phoneNumber, Date birthday) {
        String sql="UPDATE user SET name=?,phoneNumber=?,birthday=? WHERE email=?";
        boolean flag=DbUtils.update(sql,name,phoneNumber,birthday,email);
        return flag;
    }

    public Integer saveMyPlayList(MyPlayList myPlayList) {
        String sql="INSERT INTO myplaylists(userId,title,pic,createDate) VALUES (?,?,?,?)";
        Integer flag=DbUtils.updateAndGetKey(sql,myPlayList.getUserId(),myPlayList.getTitle(),myPlayList.getPic(),myPlayList.getCreateDate());
        return  flag;
    }

    public boolean cancelMyPlayList(String title,Integer userId) {
        String sql="delete from myplaylists where title=? and userId=?";
        boolean flag=DbUtils.update(sql,title,userId);
        return flag;
    }

    public boolean updateName(String name,Integer id) {
        String sql="UPDATE user SET name=? WHERE id=?";
        return DbUtils.update(sql,name,id);
    }
}
