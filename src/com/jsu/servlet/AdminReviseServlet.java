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

@WebServlet(urlPatterns = "/AdminReviseServlet")
public class AdminReviseServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request,response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String adAccount=request.getParameter("adAccount");
        String adPassword=request.getParameter("adPassword");
        String adAfterPassword=request.getParameter("adAfterPassword");
        AdminDao adminDao= new AdminDao();
        Admin admin = adminDao.getAdmin(adAccount,adPassword);
        if (admin!=null){
            Boolean flag=adminDao.revisePassword(adAccount,adAfterPassword);
            if (flag){
                request.getRequestDispatcher("/backUpdate.jsp").forward(request,response);
                PrintWriter writer = response.getWriter();
                writer.write("<script>");
                writer.write("alert('Update Succeed');");
                writer.write("</script>");
                writer.flush();
                writer.close();

            }else {

            }
        }else{
            System.out.println("账号或原密码错误");
        }

    }
}
