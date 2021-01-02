package com.jsu.filter;

import com.jsu.bean.Page;
import com.jsu.bean.PlayList;
import com.jsu.bean.Song;
import com.jsu.dao.PlayListDao;
import com.jsu.dao.SongDao;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.annotation.WebInitParam;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebFilter(urlPatterns ={ "/top2.jsp"})
public class LoginFilter implements Filter {
    public void destroy() {
    }

    public void doFilter(ServletRequest req, ServletResponse resp, FilterChain chain) throws ServletException, IOException {
        //类型转换
        HttpServletRequest request=(HttpServletRequest)req;
        HttpServletResponse response=(HttpServletResponse)resp;
        request.setCharacterEncoding("UTF-8");
        PlayListDao playListDao = new PlayListDao();
        SongDao songDao = new SongDao();
        StringBuffer sqlRow=new StringBuffer("SELECT title,createDate,pic FROM playlists limit 0,6");
        List<PlayList> playList= playListDao.getPlayList(sqlRow.toString());
        Page playPage=new Page(playList);
        //request.getSession().setAttribute("playPage",playPage);
        String sql="SELECT songName,singerName,type,playCount,url FROM song order by playCount desc limit 0,7";
        List<Song> songList= songDao.getSongList(sql);
       // request.getSession().setAttribute("upPage",songList);
        String sql1="SELECT songName,singerName,type,playCount,url FROM song order by RAND() LIMIT 7";
        List<Song> newSongList= songDao.getSongList(sql1);
       // request.getSession().setAttribute("newPage",newSongList);
        request.getServletContext().setAttribute("upPage",songList);
        request.getServletContext().setAttribute("newPage",newSongList);
        request.getServletContext().setAttribute("playPage",playPage);
        chain.doFilter(req, resp);
    }

    public void init(FilterConfig config) throws ServletException {
    }

}
