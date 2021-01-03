package test;


import com.jsu.dao.AdminDao;
import com.jsu.dao.UserDao;
import org.junit.Test;


public class test {

    AdminDao adminDao=  new AdminDao();
    UserDao userDao=  new UserDao();
    @Test
    public void adminLogin(){

        String count="123";
        String password="123456";
        adminDao.getAdmin(count,password);
    }
    @Test
    public void adminRegister(){
        String count="123";
        String password="123";
       boolean flag=adminDao.revisePassword(count,password);
        System.out.println(flag);
    }
    @Test
    public void userLogin(){
        String email="123@123.com";
        String password="123";
        userDao.getUser(email,password);
    }
    @Test
    public void comment(){
        String sql="select * from user";
        userDao.getUserCount(sql);
    }
}
