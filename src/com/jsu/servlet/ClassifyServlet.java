package com.jsu.servlet;

import com.jsu.bean.Song;
import com.jsu.dao.SongDao;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(urlPatterns = "/ClassifyServlet")
public class ClassifyServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String method=request.getParameter("method");
        SongDao songDao=new SongDao();
        if (method.equals("allSong")){
            String sql="select * from song";
            List<Song> allSong=songDao.getSongList(sql);
            request.setAttribute("allSong",allSong);
        }else if(method.equals("classify")){
            String type="%"+request.getParameter("type")+"%";
            String sql="SELECT * FROM `song` WHERE type LIKE ?";
            List<Song> songList=songDao.getSongList(sql,type);
            request.setAttribute("allSong",songList);
        }
        request.getRequestDispatcher("/classifySong.jsp").forward(request,response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }
}
