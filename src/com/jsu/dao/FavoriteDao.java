package com.jsu.dao;

import com.jsu.utils.DbUtils;

public class FavoriteDao {
    public boolean addSongToFavorite(Integer userId,Integer songId){
        String sql="INSERT INTO favorite(userId,songId) values(?,?)";
        return DbUtils.save(sql,userId,songId);
    }
    public boolean deleteSongInFavorite(Integer userId,Integer songId){
        String sql="DELETE FROM favorite where userId=? and songId=?";
        return DbUtils.update(sql,userId,songId);
    }
}
