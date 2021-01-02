package com.jsu.servlet;

import com.jsu.bean.MyPlayList;
import com.jsu.bean.PlayList;
import com.jsu.bean.Song;
import com.jsu.bean.User;
import com.jsu.dao.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import java.util.List;

@WebServlet(urlPatterns = "/UserOperateServlet")
public class UserOperateServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String method=request.getParameter("method");
        UserDao userDao =  new UserDao();
        PlayListDao playListDao= new PlayListDao();
        //收藏歌单
        if (method.equals("colletList")){
            String title=request.getParameter("title");
            Integer userId=Integer.valueOf(request.getParameter("userId"));
            //通过想收藏的歌单名获取这个歌单
            PlayList playList=playListDao.getPlayListBytitle(title);
            MyPlayList myPlayList = new MyPlayList(null,userId,playList.getTitle(),playList.getPic(),new Date());
            //将这个歌单存到自己的歌单中
            Integer count=userDao.saveMyPlayList(myPlayList);
            //获取所有存储在歌单中的歌曲
            List<Song> allSong=playListDao.getAllSong2(playList.getId());
            for (Song song:allSong){
                playListDao.saveMyListIdAndSongId(song.getId(),count);
            }
            if (count>0){
                System.out.println("收藏歌单成功");
            }else {
                System.out.println("收藏歌单失败");
            }
        }
        //取消收藏歌单
        else if (method.equals("cancelList")){
            String title=request.getParameter("title");
            Integer userId=Integer.valueOf(request.getParameter("userId"));
            PlayList playList = playListDao.getMyPlayListBytitle(title,userId);
            //删除歌单
            boolean flag1=userDao.cancelMyPlayList(title,userId);
            //删除存在中间表中的歌曲
            boolean flag2=playListDao.deleteSongsByMyPlayListId(playList.getId());
            boolean flag=flag1&&flag2;
            if (flag){
                System.out.println("成功取消收藏");
            }else {
                System.out.println("取消收藏失败");
            }
        }
        //收藏歌曲
        else if (method.equals("collectSong")){
           String songName=request.getParameter("songName");
            Integer userId=Integer.valueOf(request.getParameter("userId"));
            SongDao songDao= new SongDao();
            Song song=songDao.getSongId(songName);
            FavoriteDao favoriteDao= new FavoriteDao();
            boolean flag=favoriteDao.addSongToFavorite(userId,song.getId());
            if (flag){
                System.out.println("收藏成功");
            }else {
                System.out.println("收藏失败");
            }
        }
        //取消收藏歌曲
        else if (method.equals("cancelSong")){
            String songName=request.getParameter("songName");
            Integer userId=Integer.valueOf(request.getParameter("userId"));
            SongDao songDao= new SongDao();
            Song song=songDao.getSongId(songName);
            FavoriteDao favoriteDao= new FavoriteDao();
            boolean flag=favoriteDao.deleteSongInFavorite(userId,song.getId());
            if (flag){
                System.out.println("成功取消收藏");
            }else {
                System.out.println("取消收藏失败");
            }
        }
        //添加评论
        else if (method.equals("comment")){
            User user= (User) request.getSession().getAttribute("SESSION_USER");
            Integer playListsId=Integer.valueOf(request.getParameter("playListsId"));
            PlayList playList=playListDao.getPlayListById(playListsId);
            String title=playList.getTitle();
            String content=request.getParameter("content");
            CommentDao commentDao = new CommentDao();
            Boolean flag=commentDao.saveComment(content,user,playListsId);
            if (flag){
                System.out.println("评论成功");
            }else {
                System.out.println("评论失败");
            }
        }
        else if (method.equals("myHome")){
            Integer userId=Integer.valueOf(request.getParameter("userId"));
            List<MyPlayList> myPlayList=playListDao.getMyPlayListById(userId);
            System.out.println(myPlayList);
            request.setAttribute("myPlayList",myPlayList);
            request.getRequestDispatcher("/myHome.jsp").forward(request,response);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }
}
