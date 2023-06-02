package Connect;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

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
public class Signup extends HttpServlet {

    private String feedback;
  
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        
        try {
            response.setContentType("text/html;charset=UTF-8");
            PrintWriter out = response.getWriter();
            
            HttpSession session = request.getSession();
            String fname = request.getParameter("fname");
            String uname = request.getParameter("uname");
            String email = request.getParameter("email");
            String pword = request.getParameter("pword");
            
            session.setAttribute("fname", fname);
            session.setAttribute("uname", uname);
            session.setAttribute("email", email);
            session.setAttribute("pword", pword);
            //response.sendRedirect("ProfileDescription.html");
            
            ConnectDAO dao = new ConnectDAO("Plandi","Card@4817","Connect");
            feedback = dao.avail_check(uname, email);
            if(feedback == "Username taken"){
                
                out.print(feedback);
            }
            
            else if(feedback =="Email taken"){
                out.print(feedback);
            }
            else if(feedback =="available"){
                //response.sendRedirect("ProfileDescription.html");
                out.print("available");
            }
            
            dao.getCon().close();
        } catch (SQLException ex) {
            Logger.getLogger(Signup.class.getName()).log(Level.SEVERE, null, ex);
        }
        }
    }



