package com.jsu.dao;

import com.jsu.bean.MyPlayList;
import com.jsu.bean.PlayList;
import com.jsu.bean.Song;
import com.jsu.utils.DbUtils;
import com.mysql.cj.xdevapi.DbDoc;

import java.util.List;

public class PlayListDao {
    public Integer getPlayCount(String sql,Object...param) {
        Integer count=DbUtils.getCount(sql,param);
        return count;
    }

    public List<PlayList> getPlayList(String sql) {
        List<PlayList> playList= DbUtils.getList(PlayList.class,sql);
        return  playList;
    }

    public PlayList getPlayListBytitle(String title) {
        String sql="SELECT id,title,createDate,pic FROM playlists WHERE title=?";
        PlayList playList=DbUtils.getSingleObj(PlayList.class,sql,title);
        return  playList;
    }
    public PlayList getPlayListById(Integer playListsId){
        String sql="select id,title,createDate FROM playlists WHERE id=?";
        return DbUtils.getSingleObj(PlayList.class,sql,playListsId);
    }
    public PlayList getMyPlayListBytitle(String title,Integer userId) {
        String sql="SELECT id,title,createDate,pic FROM myplaylists WHERE title=? and userId=?";
        PlayList playList=DbUtils.getSingleObj(PlayList.class,sql,title,userId);
        return  playList;
    }

    public List<Song> getAllSong(Integer id) {
       String  sql="SELECT songName,singerName,type,playCount,url FROM song WHERE id IN(\n" +
               "SELECT songId FROM list WHERE playlistsId=?)";
       List<Song> songList= DbUtils.getList(Song.class,sql,id);
       return songList;
    }
    public List<Song> getAllSong2(Integer id) {
        String  sql="SELECT id,songName,singerName,type,playCount,url FROM song WHERE id IN(\n" +
                "SELECT songId FROM list WHERE playlistsId=?)";
        List<Song> songList= DbUtils.getList(Song.class,sql,id);
        return songList;
    }

    public boolean saveListIdAndSongId(Integer songId, Integer playListId) {
        String sql="INSERT INTO list (songId,playlistsId) VALUES(?,?)";
        return DbUtils.save(sql,songId,playListId);
    }
    public boolean saveMyListIdAndSongId(Integer songId, Integer playListId) {
        String sql="INSERT INTO mylist (songId,myPlayListsId) VALUES(?,?)";
        return DbUtils.save(sql,songId,playListId);
    }
    public boolean deleteSongInList(Integer songId) {
        String sql="DELETE FROM list WHERE songId=?";
        return DbUtils.update(sql,songId);
    }

    public boolean savePlayList(PlayList playList) {
        String sql="INSERT INTO playlists (id,title,createDate,pic) VALUES(?,?,?,?)";
        boolean flag= DbUtils.save(sql,playList.getId(),playList.getTitle(),playList.getCreateDate(),playList.getPic());
        return flag;
    }

    public boolean update(String beforeName, String title) {
        String sql="UPDATE playlists SET title=? WHERE title=?";
        boolean flag=DbUtils.update(sql,title,beforeName);
        return flag;
    }
    public  boolean deleteSongsByMyPlayListId(Integer myPlayListId){
        String sql="DELETE FROM mylist where myPlayListsId=?";
        boolean flag=DbUtils.update(sql,myPlayListId);
        return flag;
    }

    public List<MyPlayList> getMyPlayListById(Integer userId) {
        String sql="SELECT id,userId,title,pic,createDate FROM myplaylists WHERE userId=?";
        return DbUtils.getList(MyPlayList.class,sql,userId);
    }
}
