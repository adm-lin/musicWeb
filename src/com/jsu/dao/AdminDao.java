package com.jsu.dao;

import com.jsu.bean.Admin;
import com.jsu.bean.User;
import com.jsu.utils.DbUtils;

public class AdminDao {
    public Admin getAdmin(String account,String password){
        String sql="select id,account,password from admin where account=? and password=? ";
        Admin admin= DbUtils.getSingleObj(Admin.class,sql,account,password);
        System.out.println(admin);
        return admin;
    }

    public boolean revisePassword(String account, String adAfterPassword) {
        String sql="UPDATE admin SET `password`=? WHERE account=?";
        boolean flag = DbUtils.update(sql,adAfterPassword,account);
        return flag;
    }
}
