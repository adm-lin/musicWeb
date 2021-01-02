package com.jsu.dao;

import com.jsu.bean.Song;
import com.jsu.utils.DbUtils;

import java.util.List;

public class SongDao {
    public boolean saveSong(Song song) {
        String sql="INSERT INTO song (songName,singerName,type,playCount,url) VALUES(?,?,?,?,?)";
        boolean flag= DbUtils.save(sql,song.getSongName(),song.getSingerName(),song.getType(),song.getPlayCount(),song.getUrl());
        return flag;
    }

    public Integer deleteSong(String songName) {
        String sql="DELETE FROM song WHERE songName=?";
        Integer key=DbUtils.updateAndGetKey(sql,songName);
        return key;
    }

    public boolean upDateSong(Song song,String beforeName) {
        String sql="UPDATE song SET songName=?,singerName=?,type=?,playCount=? WHERE songName=?";
        boolean flag=DbUtils.update(sql,song.getSongName(),song.getSingerName(),song.getType(),song.getPlayCount(),beforeName);
        return flag;
    }

    public List<Song> getSongList(String sql,Object...param) {
        List<Song> songList=DbUtils.getList(Song.class,sql,param);
        return  songList;
    }


    public Integer getSongCount(String sql,Object...param) {
        Integer count=DbUtils.getCount(sql,param);
        return count;
    }

    public Integer saveSongAndReturnId(Song song) {
        String sql="INSERT INTO song (songName,singerName,type,playCount,url) VALUES(?,?,?,?,?)";
        Integer key=DbUtils.updateAndGetKey(sql,song.getSongName(),song.getSingerName(),song.getType(),song.getPlayCount(),song.getUrl());
        return key;
    }

    public Song getSongId(String songName) {
        String sql="SELECT id,songName FROM song WHERE songName=?";
        return DbUtils.getSingleObj(Song.class,sql,songName);
    }
    public boolean updateSongCount(Integer playCount,String songName){
        String sql="update song set playCount=? where songName=?";
        boolean flag=DbUtils.update(sql,playCount,songName);
        return flag;
    }
}
