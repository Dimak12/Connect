/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Connect;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author PLANDI
 */
public class ConnectDAO {
    
    private Connection con;
    private PreparedStatement pst;
    private PreparedStatement pstmnt;
    private String feedback;
    private ResultSet rs;
    
    public ConnectDAO(String user,String password,String dbName){
        
        String url = "jdbc:mysql://localhost:3306/"+dbName;  
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con= DriverManager.getConnection(url,user,password);
        } catch (SQLException|ClassNotFoundException ex) {
            System.out.println(ex);
        }
    }

    public Connection getCon() {
        return con;
    }

    public String getFeedback() {
        return feedback;
    }

    public ResultSet getRs() {
        return rs;
    }
    
    
    public String signup(String fname, String uname, String email, String pword, String bio, String path){
        
        String insert = "insert into users(username,full_name,email,password,bio,profile_pic) values(?,?,?,?,?,?)";
        
        int i = 0;
        try {
            
            pst = con.prepareStatement(insert);
            pst.setString(1, uname);
            pst.setString(2, fname);
            pst.setString(3, email);
            pst.setString(4, pword);
            pst.setString(5, bio);
            pst.setString(6, path);
            
            i = pst.executeUpdate();

            if(i>0){

                feedback = "success";
            }

            else {

                feedback = "failed";
            }
            
            
        } catch (SQLException ex) {
            Logger.getLogger(ConnectDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        return feedback;
    }
    
    public String avail_check(String uname, String email){
        
        String uname_query = "select email from users where username = ?";
        String email_query = "select username from users where email = ?";
        ResultSet result= null;
        
        try{
            
            pst = con.prepareStatement(uname_query);
            pstmnt = con.prepareStatement(email_query);
            pst.setString(1, uname);
            pstmnt.setString(1, email);
            rs = pst.executeQuery();
            result = pstmnt.executeQuery();
            
            if(rs.next()){
                
                feedback = "Username taken";
            }
            
            else if(result.next()){
                
                feedback = "Email taken";
            }
            
            else{
                feedback = "available";
            }
            
        }catch(SQLException e){
            
        }
        
        return feedback;
    }
    
    public String login(String uname, String pword){
        String query = "select * from users where username = ? and password = ?";
        try{
            pst = con.prepareStatement(query);
            pst.setString(1, uname);
            pst.setString(2, pword);
            rs = pst.executeQuery();
            if(!rs.next()){
                
                feedback = "not found";
            }
            
            else{
                feedback = "exists";
            }
            
        }catch(SQLException e){
            e.printStackTrace();
        }
        return feedback;
    }
    
    public ResultSet userInfo(String user){
        String query = "select * from users where username = ?";
        try{
            
            pst = con.prepareStatement(query);
            pst.setString(1, user);
            rs = pst.executeQuery();
        }catch(SQLException e){
            e.printStackTrace();
        }
        
        return rs;
    }
    
    public String postUpdate(String uname,String message){
        
        String insert = "insert into posts(message,username) values(?,?)";
        String query = "select date from posts order by id desc limit 1";
        int i = 0;
        try{
            pst = con.prepareStatement(insert);
            pstmnt = con.prepareStatement(query);
            
            pst.setString(1, message);
            pst.setString(2, uname);
            
            i = pst.executeUpdate();
            if(i>0){
                rs = pstmnt.executeQuery();
                while(rs.next()){
                    String date = rs.getString("date");
                    feedback = date;
                }
                
            }
            else{
                feedback = "failed";
            }
            
            
        }catch(SQLException e){
            e.printStackTrace();
        }
        return feedback;
    }
    
    public ResultSet search(String search){
        
        String query = "select * from users where full_name like ? or username like ? ";
        try{
            
            pst = con.prepareStatement(query);
            pst.setString(1, "%"+search+"%");
            pst.setString(2, "%"+search+"%");
            
            rs = pst.executeQuery();
            
        }catch(SQLException e){
            e.printStackTrace();
        }
        
        return rs;
    }
    
    public ResultSet followCheck(String user,String following){
        
        String query = "select * from follows where username = ? and following = ? ";
        try{
            
            pst = con.prepareStatement(query);
            pst.setString(1, user);
            pst.setString(2, following);
            
            rs = pst.executeQuery();
            
        }catch(SQLException e){
            e.printStackTrace();
        }
        
        return rs;
    }
    
    public void follow(String uname, String username){
        
        String insert = "insert into follows values(?,?)";
        try{
            pst = con.prepareStatement(insert);
            pst.setString(1, uname);
            pst.setString(2, username);
            pst.executeUpdate();
            
        }catch(SQLException e){
            e.printStackTrace();
        }
    }
    
    public void unfollow(String uname, String username){
        
        String insert = "delete from follows where username =? and following = ?";
        try{
            pst = con.prepareStatement(insert);
            pst.setString(1, uname);
            pst.setString(2, username);
            pst.executeUpdate();
            
        }catch(SQLException e){
            e.printStackTrace();
        }
    }
    
    public ResultSet feed(String uname){
        
        String query = "select posts.message, posts.username, posts.date, users.full_name, users.profile_pic from posts "
                + "inner join follows on posts.username = follows.following inner join users on posts.username = users.username "
                + "where follows.username = ? order by posts.id desc";
        
        try{
            
            pst = con.prepareStatement(query);
            pst.setString(1, uname);
            rs = pst.executeQuery();
            
        }catch(SQLException e){
            e.printStackTrace();
        }
        
        return rs;
    }
    
    public String updateProfile(String uname, String bio, String path){
        String update = "update users set profile_pic = ? ,bio = ? where username = ? ";
        int i = 0;
        try{
            pst = con.prepareStatement(update);
            pst.setString(1, path);
            pst.setString(2, bio);
            pst.setString(3, uname);
            i = pst.executeUpdate();
            
            if(i>0){
                feedback = "success";
            }
            else{
                feedback = "failed";
            }
            
        }catch(SQLException e){
            e.printStackTrace();
        }
        
        return feedback;
    }
    
    
}
