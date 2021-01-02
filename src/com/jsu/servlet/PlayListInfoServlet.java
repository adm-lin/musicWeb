package com.jsu.servlet;

import com.google.gson.Gson;
import com.jsu.bean.Page;
import com.jsu.bean.PlayList;
import com.jsu.bean.Song;
import com.jsu.dao.PlayListDao;
import com.jsu.dao.SongDao;
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
import java.util.Date;
import java.util.List;

@WebServlet(urlPatterns = "/PlayListInfoServlet")
public class PlayListInfoServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        String method = request.getParameter("method");
        if (method.equals("playList")){
            String pageSizeStr = request.getParameter("pageSize");
            Integer pageSize=null;
            if (pageSizeStr!=null&&pageSizeStr.length()>0){
                pageSize=Integer.valueOf(pageSizeStr);
            }else {
                pageSize=6;
            }
            String currentPageStr = request.getParameter("currentPage");
            Integer currentPage=null;
            if (currentPageStr!=null&&currentPageStr.length()>0){
                currentPage=Integer.valueOf(currentPageStr);
            }else {
                currentPage=1;
            }
            Integer totalRows=0;
            PlayListDao playListDao = new PlayListDao();
            String sqlCount="select count(*) from playlists";
            totalRows=playListDao.getPlayCount(sqlCount);

            Integer startRow = (currentPage-1)*pageSize;
            StringBuffer sqlRow=new StringBuffer("SELECT title,createDate,pic FROM playlists ");
            sqlRow.append(" limit ").append(startRow).append(",").append(pageSize);

            List<PlayList> playList= playListDao.getPlayList(sqlRow.toString());
            Page playPage=new Page( currentPage,  pageSize,  totalRows,  playList);
            request.setAttribute("playPage",playPage);
            request.getRequestDispatcher("/playListCompile.jsp").forward(request,response);
        }else if (method.equals("songAdd")){
            Song song=requestGetObj(request);
            PlayListDao playListDao= new PlayListDao();
            PlayList playList=playListDao.getPlayListBytitle(title);
            SongDao songDao=new SongDao();
            Integer songId=songDao.saveSongAndReturnId(song);
            boolean flag=playListDao.saveListIdAndSongId(songId,playList.getId());
            if (flag){
                response.sendRedirect("/musicWeb/PlayListInfoServlet?method=playList");
            }else {
                PrintWriter writer = response.getWriter();
                writer.write("<script>");
                writer.write("alert('Add Fail');");
                writer.write("</script>");
                writer.flush();
                writer.close();
            }
        }else if (method.equals(("add"))){
          //  String title=request.getParameter("title");
            PlayList playList=requestGetObj2(request);
            PlayListDao playListDao = new PlayListDao();
            boolean flag=playListDao.savePlayList(playList);
            if (flag){
                response.sendRedirect("/musicWeb/PlayListInfoServlet?method=playList");
            }else {
                PrintWriter writer = response.getWriter();
                writer.write("<script>");
                writer.write("alert('Add Fail');");
                writer.write("</script>");
                writer.flush();
                writer.close();
            }
        }else if (method.equals("update")){
            String title=request.getParameter("title");
            String beforeName=request.getParameter("beforeName");
            PlayListDao playListDao = new PlayListDao();
            boolean flag=playListDao.update(beforeName,title);
            if (flag){
                response.sendRedirect("/musicWeb/PlayListInfoServlet?method=playList");
            }else {
                PrintWriter writer = response.getWriter();
                writer.write("<script>");
                writer.write("alert('Add Fail');");
                writer.write("</script>");
                writer.flush();
                writer.close();
            }
        }else if (method.equals("allPlayLists")){
            PlayListDao playListDao = new PlayListDao();
            StringBuffer sqlRow=new StringBuffer("SELECT title,createDate,pic FROM playlists");
            List<PlayList> playList= playListDao.getPlayList(sqlRow.toString());
            request.setAttribute("allPlayLists",playList);
            request.getRequestDispatcher("/allPlayList.jsp").forward(request,response);
        }

    }
    private PlayList requestGetObj2(HttpServletRequest request) {
        String title=null;
        String pic=null;
        String filename =null;
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
                        if("title".equals(fileItem.getFieldName())){
                            System.out.println("表单项的的name属性值:"+fileItem.getFieldName());
                            title=new String(fileItem.getString().getBytes("iso-8859-1"),"UTF-8");
                        }
                    }else{
                        //获取服务器下路径
                        String dir=this.getServletContext().getRealPath("/images/playListImages");
                        String  sdir = dir+"\\"+fileItem.getName();
                        System.out.println(sdir);
                        filename = fileItem.getName();
                        pic="images/playListImages/"+filename;
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
        PlayList playList=  new PlayList(null,title,new Date(),pic);
        return playList;
    }
    String title=null;
    private Song requestGetObj(HttpServletRequest request) {
        String songName=null;
        String type=null;
        String singerName=null;
        String filename =null;
        String url=null;
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
                        System.out.println("表单项的的name属性值:"+fileItem.getFieldName());
                        if("songName".equals(fileItem.getFieldName())){
                            songName=new String(fileItem.getString().getBytes("iso-8859-1"),"UTF-8");
                        }else if("singerName".equals(fileItem.getFieldName())){
                            singerName=new String(fileItem.getString().getBytes("iso-8859-1"),"UTF-8");
                        }else if("type".equals(fileItem.getFieldName())){
                            type=new String(fileItem.getString().getBytes("iso-8859-1"),"UTF-8");
                        }else if("title".equals(fileItem.getFieldName())){
                            title=new String(fileItem.getString().getBytes("iso-8859-1"),"UTF-8");
                        }
                    }else{
                        //获取服务器下路径
                        String dir=this.getServletContext().getRealPath("/songs");
                        String  sdir = dir+"\\"+fileItem.getName();
                        System.out.println(sdir);
                        filename = fileItem.getName();

                        url="songs/"+filename;
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
        Song song = new Song(null,songName,singerName,type,0,url);
        return song;
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }
}
