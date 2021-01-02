package com.jsu.utils;

import javax.sql.*;
import java.io.InputStream;
import java.sql.*;
import java.util.*;

import com.alibaba.druid.pool.DruidDataSourceFactory;
import org.apache.commons.beanutils.BeanUtils;

public class DbUtils {
    static Connection getConnection() throws Exception {
        //读取配置文件
        InputStream in = Thread.currentThread().getContextClassLoader().getResourceAsStream("config/db.properties");
        Properties properties=new Properties();
        properties.load(in);

        DataSource dataSource = DruidDataSourceFactory.createDataSource(properties);
        return dataSource.getConnection();
    }
    public static <T> T getSingleObj(Class<T> clazz, String sql, Object...args)  {
        Connection conn=null;
        PreparedStatement ps=null;
        ResultSet rs=null;
        T bean=null;
        try{
            conn= DbUtils.getConnection();
            ps = conn.prepareStatement(sql);

            if(args!=null&&args.length>0){
                for(int i=0;i<args.length;i++){
                    ps.setObject(i+1,args[i]);
                }
            }

            rs=ps.executeQuery();

            //获取结果集元数据
            ResultSetMetaData rsmd=rs.getMetaData();
            //获取当前结果集的列数
            int colnum= rsmd.getColumnCount();

            while(rs.next()){

                //key存放列名，value存放列值，for循环完成之后，rowmap存放了一条记录
                Map<String,Object> rowMap=new HashMap<String,Object>();
                for(int i=1;i<=colnum;i++){
                    String columnName= rsmd.getColumnLabel(i);
                    Object columnValue=rs.getObject(columnName);

                    if(columnValue instanceof java.sql.Date){
                        java.sql.Date date=(java.sql.Date)columnValue;
                        columnValue=new java.util.Date(date.getTime());
                    }
                    rowMap.put(columnName,columnValue);
                }

                //创建一个User对象，给这个user对象属性赋值；
                bean= clazz.newInstance();

                for(Map.Entry<String,Object> entry:rowMap.entrySet()){
                    String propertyName = entry.getKey();
                    Object propertyValue= entry.getValue();
                    BeanUtils.setProperty(bean,propertyName,propertyValue);
                }

            }
        }catch (Exception e){
            e.printStackTrace();
        }finally {
            close(conn, ps, rs);
        }

        return  bean;
    }
    public static void close(Connection conn, Statement ps, ResultSet rs) {
        if(rs!=null){
            try {
                rs.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        if(ps!=null){
            try {
                ps.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        if(conn!=null){
            try {
                conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    public static boolean isEmailExist(String sql, String email) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn=DbUtils.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, email);
            rs = pstmt.executeQuery();
            if (rs.next()){
                return true;
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DbUtils.close(conn, pstmt,rs );
        }
        return false;
    }

    public static boolean save(String sql, Object...args) {
        Connection conn=null;
        PreparedStatement ps=null;
        Integer count=null;
        try{
            conn= DbUtils.getConnection();
            ps = conn.prepareStatement(sql,Statement.RETURN_GENERATED_KEYS);

            if(args!=null&&args.length>0){
                for(int i=0;i<args.length;i++){
                    ps.setObject(i+1,args[i]);
                }
            }
            count=ps.executeUpdate();
        }catch (Exception e){
            e.printStackTrace();
        }finally {
            close(conn, ps, null);
        }
        return count!=null&&count>0?true:false;
    }

    public static boolean update(String sql, Object...args) {
        Connection conn=null;
        PreparedStatement ps=null;
        Integer count=0;
        try{
            conn= DbUtils.getConnection();
            ps = conn.prepareStatement(sql);

            if(args!=null&&args.length>0){
                for(int i=0;i<args.length;i++){
                    if(args[i] instanceof  java.util.Date){
                        java.util.Date date=(java.util.Date)args[i];
                        args[i]=new java.sql.Date(date.getTime());
                    }
                    ps.setObject(i+1,args[i]);
                }
            }
            count=ps.executeUpdate();
        }catch (Exception e){
            e.printStackTrace();
        }finally {
            close(conn, ps, null);
        }
        return  count>0?true:false;

    }
    public static <T> List<T> getList(Class<T> clazz, String sql, Object...args)  {
        Connection conn=null;
        PreparedStatement ps=null;
        ResultSet rs=null;
        List<T> list=null;
        try{
            conn= DbUtils.getConnection();
            ps = conn.prepareStatement(sql);

            if(args!=null&&args.length>0){
                for(int i=0;i<args.length;i++){
                    ps.setObject(i+1,args[i]);
                }
            }


            rs=ps.executeQuery();

            //获取结果集元数据
            ResultSetMetaData rsmd=rs.getMetaData();
            //获取当前结果集的列数
            int colnum= rsmd.getColumnCount();

            list=new ArrayList<>();

            while(rs.next()){

                //key存放列名，value存放列值，for循环完成之后，rowmap存放了一条记录
                Map<String,Object> rowMap=new HashMap<String,Object>();
                for(int i=1;i<=colnum;i++){
                    String columnName= rsmd.getColumnLabel(i);
                    Object columnValue=rs.getObject(columnName);

                    if(columnValue instanceof java.sql.Date){
                        java.sql.Date date=(java.sql.Date)columnValue;
                        columnValue=new java.util.Date(date.getTime());
                    }
                    rowMap.put(columnName,columnValue);
                }

                //创建一个User对象，给这个user对象属性赋值；
                T bean= clazz.newInstance();

                for(Map.Entry<String,Object> entry:rowMap.entrySet()){
                    String propertyName = entry.getKey();
                    Object propertyValue= entry.getValue();
                    BeanUtils.setProperty(bean,propertyName,propertyValue);
                }

                list.add(bean);
            }
        }catch (Exception e){
            e.printStackTrace();
        }finally {
            close(conn, ps, rs);
        }


        return list;
    }

    public static Integer getCount(String sql, Object...args) {
        Connection conn=null;
        PreparedStatement ps=null;
        ResultSet rs=null;
        Integer count=null;
        try{
            conn= DbUtils.getConnection();
            ps = conn.prepareStatement(sql);
            if(args!=null&&args.length>0){
                for(int i=0;i<args.length;i++){
                    ps.setObject(i+1,args[i]);
                }
            }
            rs=ps.executeQuery();
            while(rs.next()){
                count=rs.getInt(1);
            }
        }catch (Exception e){
            e.printStackTrace();
        }finally {
            close(conn, ps, rs);
        }
        return  count;
    }

    public static Integer updateAndGetKey(String sql, Object...args) {
        Connection conn=null;
        PreparedStatement ps=null;
        ResultSet rs=null;
        Integer primaryKey = null;
        try{
            conn= DbUtils.getConnection();
            ps = conn.prepareStatement(sql,Statement.RETURN_GENERATED_KEYS);

            if(args!=null&&args.length>0){
                for(int i=0;i<args.length;i++){
                    ps.setObject(i+1,args[i]);
                }
            }
            ps.executeUpdate();
            rs = ps.getGeneratedKeys();
            if(rs.next()){
                primaryKey=rs.getInt(1);

            }
        }catch (Exception e){
            e.printStackTrace();
        }finally {
            close(conn, ps, rs);
        }
        return  primaryKey;
    }
}
