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
import java.util.List;

@WebServlet(urlPatterns = "/SongInfoServlet")
public class SongInfoServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("utf-8");
        response.setContentType("text/html;charset=utf-8"); // 处理响应乱码问题
        String method = request.getParameter("method");
        if ("add".equals(method)){
            Song song=requestGetObj(request);
            SongDao songDao= new SongDao();
            boolean flag=songDao.saveSong(song);
            if (flag){
                response.sendRedirect("/musicWeb/SongInfoServlet?method=songList");
            }else {
                PrintWriter writer = response.getWriter();
                writer.write("<script>");
                writer.write("alert('Add Fail');");
                writer.write("</script>");
                writer.flush();
                writer.close();
            }
        }else if("update".equals(method)){
            String beforeName=request.getParameter("beforeName");
            Song song=requestGetObj2(request);
            SongDao songDao= new SongDao();
            boolean flag=songDao.upDateSong(song,beforeName);
            if (flag){
                response.sendRedirect("/musicWeb/SongInfoServlet?method=songList");
            }else {
                PrintWriter writer = response.getWriter();
                writer.write("<script>");
                writer.write("alert('Update Fail');");
                writer.write("</script>");
                writer.flush();
                writer.close();
            }

        }else if("delete".equals(method)) {
            String songName = request.getParameter("songName");
            SongDao songDao = new SongDao();
            PlayListDao playListDao= new PlayListDao();
            Song song=songDao.getSongId(songName);
            System.out.println(song);
            songDao.deleteSong(songName);
            boolean flag= playListDao.deleteSongInList(song.getId());
            if (flag) {
                response.sendRedirect("/musicWeb/SongInfoServlet?method=songList");
            } else {
                PrintWriter writer = response.getWriter();
                writer.write("<script>");
                writer.write("alert('Delete Fail');");
                writer.write("</script>");
                writer.flush();
                writer.close();
            }
        }else if ("songList".equals(method)){

            String type = request.getParameter("type");
            if (type==null){
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
                SongDao songDao = new SongDao();
                String sqlCount="select count(*) from song";
                totalRows=songDao.getSongCount(sqlCount);

                //起始行startRow
                Integer startRow = (currentPage-1)*pageSize;
                StringBuffer sqlRow=new StringBuffer("SELECT songName,singerName,type,playCount,url FROM song ");
                sqlRow.append(" limit ").append(startRow).append(",").append(pageSize);

                List<Song> songList= songDao.getSongList(sqlRow.toString());
                Page page=new Page( currentPage,  pageSize,  totalRows,  songList);
                request.setAttribute("page",page);
                request.getRequestDispatcher("/musicCompile.jsp").forward(request,response);
            }
            else if (type.equals("ajax")){
                String title=request.getParameter("title");
                PlayListDao playListDao= new PlayListDao();
                PlayList playList =playListDao.getPlayListBytitle(title);
                List<Song> allSong = playListDao.getAllSong(playList.getId());
               // allSong
                for (Song song:allSong){
                    System.out.println(song);
                }
                PrintWriter out = response.getWriter();
                Gson gson= new Gson();
                String songInfo=gson.toJson(allSong);
                System.out.println(songInfo);
                out.write(songInfo);
            }

        }else if("updateCount".equals(method)){
            String songName=request.getParameter("songName");
            Integer playCount=Integer.valueOf(request.getParameter("playCount"));
            playCount++;
            System.out.println(songName);
            SongDao songDao = new SongDao();
            songDao.updateSongCount(playCount,songName);
            PrintWriter out = response.getWriter();

            out.write(String.valueOf(playCount));

        }
    }

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
                        if("songName".equals(fileItem.getFieldName())){
                            System.out.println("表单项的的name属性值:"+fileItem.getFieldName());
                            songName=new String(fileItem.getString().getBytes("iso-8859-1"),"UTF-8");
                        }else if("singerName".equals(fileItem.getFieldName())){
                            System.out.println("表单项的的name属性值:"+fileItem.getFieldName());
                             singerName=new String(fileItem.getString().getBytes("iso-8859-1"),"UTF-8");
                        }else if("type".equals(fileItem.getFieldName())){
                            System.out.println("表单项的的name属性值:"+fileItem.getFieldName());
                             type=new String(fileItem.getString().getBytes("iso-8859-1"),"UTF-8");
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
    private Song requestGetObj2(HttpServletRequest request) {
        String songName = request.getParameter("songName");;
        String singerName = request.getParameter("singerName");
        String url = request.getParameter("url");
        String type = request.getParameter("type");
        Integer playCount=Integer.valueOf(request.getParameter("playCount"));
        Song song = new Song(null,songName,singerName,type,playCount,url);
        return song;
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }
}
