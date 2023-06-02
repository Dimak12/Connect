
package Connect;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

/**
 *
 * @author PLANDI
 */
@MultipartConfig(maxFileSize =161772216 )
public class UpdateProfile extends HttpServlet {
    
    private String feedback;
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
    }

   
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        
        try {
            HttpSession session = request.getSession(false);
            if(session!= null){
                String uname = session.getAttribute("uname").toString();
                String bio = request.getParameter("bio");
                String folderName = "images";
                String uploadPath = request.getServletContext().getRealPath("") + folderName;
                Part picture = request.getPart("profile_pic");
                String path = null;

                File dir = new File(uploadPath);
                String fileName = picture.getSubmittedFileName();
                if(!dir.exists()){
                    dir.mkdirs();
                }

                if(fileName.isEmpty()){
                    path = session.getAttribute("picture").toString();
                }

                else{
                    path = "images/"+fileName;
                    InputStream is = picture.getInputStream();
                    Files.copy(is, Paths.get(uploadPath + File.separator + fileName), StandardCopyOption.REPLACE_EXISTING);
                }

                ConnectDAO dao = new ConnectDAO("Plandi","Card@4817","Connect");
                feedback = dao.updateProfile(uname, bio, path);

                if(feedback == "success"){
                    response.sendRedirect("MyProfile.jsp");
                }
                else{
                    out.print("Something went wrong!");
                }
                dao.getCon().close();
            
        }
            else{
                response.sendRedirect("index.html");

            }
            
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        
    }

  

}
