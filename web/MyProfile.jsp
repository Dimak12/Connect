<%-- 
    Document   : MyProfile
    Created on : 06 Nov 2021, 10:16:25 PM
    Author     : PLANDI
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="Connect.ConnectDAO"%>

<%
    ResultSet rs,result;
    ConnectDAO dao;
    

%>



<%
        session = request.getSession(false);
        if(session.getAttribute("uname")!= null){
            
            String user = session.getAttribute("uname").toString();
            String picture = null;
            String bio = null;
            dao = new ConnectDAO("Plandi","Card@4817","Connect");
            rs = dao.userInfo(user);
            
            while(rs.next()){
                picture = rs.getString("profile_pic");
                bio = rs.getString("bio");
            }
            session.setAttribute("picture", picture);
            dao.getCon().close();
            
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <title>Connect | Profile</title>
        <style>
            
            *{
                box-sizing: border-box;
                margin: 0px;
                padding: 0px;
            }
            html {
                font-family: system-ui, -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Ubuntu, "Helvetica Neue", sans-serif;
            }
            
            .layout{
                display: flex;
                flex-direction: row;
                background-color: #3B4756;
                height: 100vh;
            }
            
            .navbar{
                display: flex;
                flex-direction: column;
                /*justify-content: flex-start;*/
                
                
                background: #1C2E5B;
                color: white;
                   
            }
            .navbar img{
                justify-content: flex-start;
                margin-bottom: 40px;
                
            }
            
            .feed{
                
                margin:0px auto;
                width: 700px;
                height: 100vh;
                overflow-y: scroll;
                background: white;
               
                border-left: 1px solid #ddd;
                border-right: 1px solid #ddd;
                
            }
            
            .feed::-webkit-scrollbar {
                display: none;
            }
            
            .feed{
                
                -ms-overflow-style: none;
                scrollbar-width: none;
            }
            
            
            
            .nav_options{
                display: flex;
                justify-content:center;
                margin:20px auto;
                font-size: 30px;
                width: 50%;
                height: 50px;
                background: #334272;
                border-radius: 30px;
                
            }
            
            .nav_options a {
                
                text-decoration: none;
                color: white;
            }
            
            .nav_options a:visited{
                
                color: white;
                text-decoration: none;
            }
            
            .home_icon, .profile_icon{
                
                margin-right: 10px;
                
            }
            
            #searchengine{
                display: flex;
                align-items: flex-start;
                height: 100%;
                border-radius: 30px;
                justify-content: center;
                width:286px;
            }
            
            .searchbtn, .searchbar{
                border-radius: 30px;
                height: 100%;
                outline: none;
                border: none;
            }
            
            .searchbar{
                
                padding: 20px;
                
            }
            
            .searchwrap{
                
                display: flex;
                width: 100%;
                border-radius: 30px;
                height: 50px;
                justify-content: center;
                
                margin: 20px 0px;
                
               
            }
            
            
            .searchbtn{
                width: 77px;
                background: #CBB26B;
                cursor: pointer;
            }
            
            .search{
                pointer-events: none;
            }
            
            .sample{
                display: none;
            }
            
            .logout{
                margin-top: 80px;
            }
            
            .wrapper {
                display: flex;
                flex-direction: column;
                background: #fff;
                margin:90px auto;
                border-radius: 10px;
                width: 400px;
                height:350px;
                overflow-x: hidden;
                overflow-y:hidden;
                
            }
            
            .signup-form{
                
                display: flex;
                flex-direction: column;
                margin: 30px 0px;
                 
            }
            
            .profile_wrapper{
                display: flex;
                justify-content: center;
                margin-bottom: 10px;
                
            }
            
            .profile_wrapper label{
                display: flex;
                height:100px;
                align-items: flex-start;
                
            }
            
            .textarea{
                height:50px;
                resize: none;
                padding:10px;
                
            }
            
            .signup-form h3{
                
                align-self: center;
                margin-bottom: 10px;
                font-family: lato,sans-serif;
            }
            
             .fa {
                margin-right: 5px;
            }
            
            #picture{
                
                width:150px;
                max-height:100px;
                border-radius: 100%;
                cursor: pointer;
                    
            }
            
            #profile-pic{
                display: none;
            }
            
            .imgRemove{
                outline: none;
                font-size: 30px;
                border: none;
                background-color: transparent;
            }
            
            .imgRemove::after{
                
                content: '\00d7';
                color: black;
                font-weight: 900;
                border-radius: 8px;
                cursor: pointer;
                    
            }
            
            .username, .password,.fullname,.email,.bio{
                
                display: flex;
                flex-direction: column;
                margin: 10px;
                
            }
            
            .input,.lab{
                
                margin:0px 15px;
                font-family: lato,sans-serif;
            }
            
            .btn{
                
                width: 80px;
                height: 35px;
                border: none;
                outline: none;
                background: #CBB26B;
                font-family: lato,sans-serif;
                cursor:pointer;
            }
            
            .button{
                display: flex;
                justify-content: center;
                margin: 20px 0px;
            }
            
            
        </style>
        
        <script>
            function imagePreview(event) {
                if (event.target.files.length > 0) {
                    let src = URL.createObjectURL(event.target.files[0]);
                    let preview = document.getElementById("picture");
                    preview.src = src;
                    preview.style.display = "block";
                }
            }
            function imageRemover() {
                var src = $("#previous_pic").attr("src");
                document.getElementById("picture").src  =src;
            }
        </script>
    </head>
    
    <body>
        <div class="layout">
            <div class="navbar">
                <img src="./images/NAVBAR.jpg" alt="logo" />
                <div class="nav_options home"><a href="MainPage.jsp"><span class="material-icons home_icon">home</span>Home</a></div>
                <div class="nav_options profile"><a href="profile.html"><span class="material-icons profile_icon">person</span>Profile</a></div>
                <div class=" searchwrap"><form id="searchengine" method="post" action="SearchResults.jsp"><input class="searchbar" type="text" name="search" required/><button type="submit" class="searchbtn"><span class="material-icons search">search</span></button></form></div>
                <div class="nav_options logout"><a href="LogOut"><span class="material-icons profile_icon">logout</span>Log Out</a></div>
            </div>
            <div class="wrapper">
                    
                    <form class="signup-form" id="signup-form" method="POST" action="UpdateProfile" enctype="multipart/form-data">
                        <h3>Select a profile picture</h3>
                        <div class="profile_wrapper">
                            <label for="profile-pic">
                                <img id="picture" src=<% out.print(picture); %> alt="profile_picture"/>
                                <button type="button" class="imgRemove" onclick="imageRemover()"></button>
                                <img src=<% out.print(picture); %> id="previous_pic" style="display:none"/>
                            </label>
                            <input type="file" id="profile-pic" accept="image/*" name="profile_pic" onchange="imagePreview(event)"/>
                        </div>
                        
                        <div class="bio">
                            <label class="lab"><i class="fa fa-book"></i>Bio</label>
                            <textarea name="bio" class="input textarea" placeholder="write your bio..."  ><% out.print(bio); %></textarea>
                        </div>
                        
                        <div class="button"><button class="btn" type="submit">Update</button></div>
                            
                        
                    </form>
                    
                </div>
        </div>
    </body>
</html>
            
<%  }
        else{
            response.sendRedirect("index.html");
        }
    %>
