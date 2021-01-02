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

@WebServlet(urlPatterns = "/UserLoginServlet")
public class UserLoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request,response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String method=request.getParameter("method");
        if (method!=null){
            request.getSession().invalidate();
            response.sendRedirect("/musicWeb/top2.jsp");
        }else {
            String email=request.getParameter("email");
            String password=request.getParameter("password");
            UserDao userDao = new UserDao();
            User user=userDao.getUser(email,password);
            if (user!=null){
                System.out.println("登录成功");
                request.getSession().setAttribute("SESSION_USER",user);
                PrintWriter writer = response.getWriter();
                writer.write("<script>");
                writer.write("window.location.href='top2.jsp'");
                writer.write("</script>");
                writer.flush();
                writer.close();

            }else{
                PrintWriter writer = response.getWriter();
                writer.write("<script>");
                writer.write("alert('用户不存在');");
                writer.write("window.location.href='home.jsp'");
                writer.write("</script>");
                writer.flush();
                writer.close();
            }
        }


    }
}
