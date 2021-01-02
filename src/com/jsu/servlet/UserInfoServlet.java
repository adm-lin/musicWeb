package com.jsu.servlet;

import com.jsu.bean.Page;
import com.jsu.bean.Song;
import com.jsu.bean.User;
import com.jsu.dao.UserDao;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@WebServlet(urlPatterns = "/UserInfoServlet")
public class UserInfoServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=utf-8"); // 处理响应乱码问题
        String method = request.getParameter("method");
        if("userList".equals(method)){
            //每页多少行pageSize
            String pageSizeStr = request.getParameter("pageSize");
            Integer pageSize=null;
            if (pageSizeStr!=null&&pageSizeStr.length()>0){
                pageSize=Integer.valueOf(pageSizeStr);
            }else {
                pageSize=8;
            }
            //当前是第几页currentPage
            String currentPageStr = request.getParameter("currentPage");
            Integer currentPage=null;
            if (currentPageStr!=null&&currentPageStr.length()>0){
                currentPage=Integer.valueOf(currentPageStr);
            }else {
                currentPage=1;
            }
            //一共有多少行数据totalRows
            Integer totalRows=0;
            UserDao userDao = new UserDao();
            String sqlCount="select count(*) from user";
            totalRows=userDao.getUserCount(sqlCount);

            //起始行startRow
            Integer startRow = (currentPage-1)*pageSize;
            StringBuffer sqlRow=new StringBuffer("SELECT name,email,phoneNumber,birthday,registerDate FROM user ");
            sqlRow.append(" limit ").append(startRow).append(",").append(pageSize);

            List<User> userList= userDao.getUserList(sqlRow.toString());
            Page userpage=new Page( currentPage,  pageSize,  totalRows,  userList);
            request.setAttribute("userPage",userpage);
            request.getRequestDispatcher("/userCompile.jsp").forward(request,response);
        }else if("add".equals(method)){
            User user=requestGetObj(request);
            UserDao userDao= new UserDao();
            boolean flag=userDao.saveUser(user);
            if (flag){
                response.sendRedirect("/musicWeb/UserInfoServlet?method=userList");
            }else {
                PrintWriter writer = response.getWriter();
                writer.write("<script>");
                writer.write("alert('Add Fail');");
                writer.write("</script>");
                writer.flush();
                writer.close();
            }

        }else if ("update".equals(method)){
            String email=request.getParameter("email");
            String name=request.getParameter("name");
            String phoneNumber=request.getParameter("phoneNumber");
            String birthdayStr=request.getParameter("birthday");
            Date birthday=null;
            SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
            try {
                birthday=sdf.parse(birthdayStr);
            } catch (ParseException e) {
                e.printStackTrace();
            }
            UserDao userDao= new UserDao();
            boolean flag=userDao.upDateUser(email,name,phoneNumber,birthday);
            if (flag){
                response.sendRedirect("/musicWeb/UserInfoServlet?method=songList");
            }else {
                PrintWriter writer = response.getWriter();
                writer.write("<script>");
                writer.write("alert('Update Fail');");
                writer.write("</script>");
                writer.flush();
                writer.close();
            }

        }else if ("update2".equals(method)){
            Integer id=Integer.valueOf(request.getParameter("userId"));
            String name=request.getParameter("name");
            UserDao userDao= new UserDao();
            boolean flag=userDao.updateName(name,id);
            if (flag){
                PrintWriter writer=response.getWriter();
                writer.write("true");
            }else {
                System.out.println("修改失败");
            }
        }
        else if ("delete".equals(method)){
            String email = request.getParameter("email");
            UserDao userDao= new UserDao();
            boolean flag = userDao.deleteUser(email);
            if (flag) {
                response.sendRedirect("/musicWeb/UserInfoServlet?method=userList");
            } else {
                PrintWriter writer = response.getWriter();
                writer.write("<script>");
                writer.write("alert('Delete Fail');");
                writer.write("</script>");
                writer.flush();
                writer.close();
            }

        }

    }
    private User requestGetObj(HttpServletRequest request) {
        String email=null;
        String password=null;
        String name=null;
        String filename =null;
        String pic=null;
        String phoneNumber=null;
        System.out.println("picUpload.......");
        //1.先判断上传的数据是否是多段的
        if(ServletFileUpload.isMultipartContent(request)){
            //创建FileItemFactory工厂实现类
            FileItemFactory fileItemFactory = new DiskFileItemFactory();
            //创建用于解析上传数据的工具类ServletFileUpload类
            ServletFileUpload servletFileUpload = new ServletFileUpload(fileItemFactory);
            try {
                //解析上传的数据，得到一个表单项FileItem
                List<FileItem> list = servletFileUpload.parseRequest(request);
                for(FileItem fileItem : list){
                    //普通表单项
                    if(fileItem.isFormField()){
                        if("email".equals(fileItem.getFieldName())){
                            System.out.println("表单项的的name属性值:"+fileItem.getFieldName());
                            email=new String(fileItem.getString().getBytes("iso-8859-1"),"UTF-8");
                        }else if("password".equals(fileItem.getFieldName())){
                            System.out.println("表单项的的name属性值:"+fileItem.getFieldName());
                            password=new String(fileItem.getString().getBytes("iso-8859-1"),"UTF-8");
                        }else if("name".equals(fileItem.getFieldName())){
                            System.out.println("表单项的的name属性值:"+fileItem.getFieldName());
                            name=new String(fileItem.getString().getBytes("iso-8859-1"),"UTF-8");
                        }else if ("phoneNumber".equals(fileItem.getFieldName())){
                            phoneNumber=new String(fileItem.getString().getBytes("iso-8859-1"),"UTF-8");
                        }
                    }else{
                        //获取服务器下路径
                        String dir=this.getServletContext().getRealPath("/images/userImages");
                        String  sdir = dir+"\\"+fileItem.getName();
                        System.out.println(sdir);
                        filename = fileItem.getName();

                        pic="images/userImages/"+filename;
                        //上传的文件
                        fileItem.write(new File(sdir));
                    }
                }
            } catch (FileUploadException e) {
                e.printStackTrace();
            }catch(Exception e){
                e.printStackTrace();
            }
        }
        User user= new User(null,email,password,new Date(),name,phoneNumber,new Date(),pic);
        return user;
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }
}
