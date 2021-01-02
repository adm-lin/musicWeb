package com.jsu.dao;

import com.jsu.bean.Comment;
import com.jsu.bean.User;
import com.jsu.utils.DbUtils;

import java.util.Date;
import java.util.List;

public class CommentDao {

    public List<Comment> getAllComment(Integer playListsId) {
        String sql="select * from comment where playListsId=?";
        return DbUtils.getList(Comment.class,sql,playListsId);
    }

    public Boolean saveComment(String content, User user,Integer playListsId) {
        String sql="INSERT INTO comment(userId,playListsId,content,commentTime,pic,userName) values(?,?,?,?,?,?)";
        return  DbUtils.save(sql,user.getId(),playListsId,content,new Date(),user.getPic(),user.getName());
    }
}
