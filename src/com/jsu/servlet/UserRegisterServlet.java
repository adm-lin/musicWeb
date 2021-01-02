package com.jsu.servlet;

import com.jsu.bean.User;
import com.jsu.dao.UserDao;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;

@WebServlet(urlPatterns = "/UserRegisterServlet")
public class UserRegisterServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println(1);
        response.setContentType("text/html;charset=UTF-8");
        String email=request.getParameter("email");
        String password=request.getParameter("password");
        User user = new User(null,email,password,new Date());
        UserDao userDao = new UserDao();
        boolean flag=userDao.isEmailExist(email);
        if (flag){
            PrintWriter writer = response.getWriter();
            writer.write("<script>");
            writer.write("alert('该EMAIL已经存在');");
            writer.write("window.location.href='home.jsp'");
            writer.write("</script>");
            writer.flush();
            writer.close();
        }else{
            boolean flag1=userDao.saveUser(user);
            if (flag1){
                System.out.println("注册成功");
            }else{
                System.out.println("注册失败");
            }
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }
}
