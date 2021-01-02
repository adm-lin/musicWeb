package com.jsu.servlet;

import com.jsu.bean.Comment;
import com.jsu.bean.PlayList;
import com.jsu.bean.Song;
import com.jsu.dao.CommentDao;
import com.jsu.dao.PlayListDao;
import com.jsu.utils.DbUtils;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(urlPatterns = "/ShowPlayListServlet")
public class ShowPlayListServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String title=request.getParameter("ids");
        //获取歌单
        String sql="SELECT id,title,createDate,pic FROM playlists where title=?";
        PlayList playList= DbUtils.getSingleObj(PlayList.class,sql,title);
        //获取这个歌单的所有歌曲
        PlayListDao playListDao= new PlayListDao();
        List<Song> allSong = playListDao.getAllSong(playList.getId());

        //获取这个歌单的所有评论
        CommentDao commentDao = new CommentDao();
        List<Comment> allComment = commentDao.getAllComment(playList.getId());

        request.setAttribute("allComment",allComment);
        request.setAttribute("playList",playList);
        request.setAttribute("allSong",allSong);
        String userId=request.getParameter("userId");
        if (userId!=null){
            String selSql="select id,userId,title,pic,createDate from myplaylists where userId=? and title=?";
            Integer count =DbUtils.getCount(selSql,userId,title);
            if (count!=null){
                String favorite="true";
                request.setAttribute("favorite",favorite);
            }
        }
        request.getRequestDispatcher("/songListContent.jsp").forward(request,response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }
}
