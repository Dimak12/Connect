/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Connect;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author PLANDI
 */
public class Follow extends HttpServlet {

    
    

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
    }

    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            response.setContentType("text/html;charset=UTF-8");
            PrintWriter out = response.getWriter();
            
            HttpSession session = request.getSession(false);
            if(session !=null){
                String uname = session.getAttribute("uname").toString();
                String username = request.getParameter("username");
                ConnectDAO dao = new ConnectDAO("Plandi","Card@4817","Connect");
                dao.follow(uname, username);
            
            dao.getCon().close();
            }
            else{
                response.sendRedirect("index.html");
            }
            
        } catch (SQLException ex) {
            Logger.getLogger(Follow.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        
    }

   

}
