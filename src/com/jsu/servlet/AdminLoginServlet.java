package com.jsu.servlet;

import com.jsu.bean.Admin;
import com.jsu.dao.AdminDao;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(urlPatterns = "/AdminLoginServlet")
public class AdminLoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request,response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String adAccount=request.getParameter("adAccount");
        String adPassword=request.getParameter("adPassword");
        String method = request.getParameter("method");
        if("login".equals(method)){
            AdminDao adminDao= new AdminDao();
            Admin admin = adminDao.getAdmin(adAccount,adPassword);
            if (admin!=null){
                System.out.println("登录成功");
                request.getSession().setAttribute("SESSION_ADMIN",admin);
                response.sendRedirect("/musicWeb/backUpdate.jsp");
            }else {
                PrintWriter writer = response.getWriter();
                writer.write("<script>");
                writer.write("alert('账户或密码错误');");
                writer.write("window.location.href='adminLogin.jsp'");
                writer.write("</script>");
                writer.flush();
                writer.close();
            }
        }else if ("exit".equals(method)){
            request.getSession().invalidate();
            response.sendRedirect("/musicWeb/adminLogin.jsp");
        }
    }
}
