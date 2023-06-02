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
public class Login extends HttpServlet {

    private String feedback;
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
            
            HttpSession session = request.getSession(true);
            String uname = request.getParameter("user");
            String pword = request.getParameter("password");
            session.setAttribute("uname", uname);
            
            ConnectDAO dao = new ConnectDAO("Plandi","Card@4817","Connect");
            feedback = dao.login(uname, pword);
            
            if(feedback == "exists"){
                
                out.print(feedback);
            }
            
            else{
                out.print("feedback");
            }
            
            dao.getCon().close();
        } catch (SQLException ex) {
            Logger.getLogger(Login.class.getName()).log(Level.SEVERE, null, ex);
        }
        
    }

}
