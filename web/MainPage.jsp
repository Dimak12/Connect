<%-- 
    Document   : MainPage
    Created on : 29 Oct 2021, 5:18:18 PM
    Author     : PLANDI
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="Connect.ConnectDAO"%>

<%
    ResultSet rs,result;
    ConnectDAO dao;
    

%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<%
        session = request.getSession(false);
        if(session.getAttribute("uname")!= null){
            
            String user = session.getAttribute("uname").toString();
            String picture = null;
            String fname = null;
            dao = new ConnectDAO("Plandi","Card@4817","Connect");
            rs = dao.userInfo(user);
            result = dao.feed(user);
            while(rs.next()){
                picture = rs.getString("profile_pic");
                fname = rs.getString("full_name");
            }
            
%>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <title>Connect | Home</title>
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
            
            .tweetbox__content img{
                height: 60px;
                width :80px;
                border-radius: 50%;
            }
            
            .tweetbox{
                
                padding-bottom: 10px;
                padding-right: 10px;
                border-bottom: 8px solid #e6ecf0;
                background: white;
            }
            
            .tweetbox__form{
                display:flex;
                flex-direction: column;
                background: white;
                
            }
            
            .tweetbox__content{
                display: flex;
                padding: 20px;
                background: white;
                
            }
            
            .tweetbox__input{
                flex:1;
                margin-left: 20px;
                font-size: 20px;
                border: none;
                outline: none;
            }
            
            .tweetbox_postbutton{
               background-color:#CBB26B;
               border: none;
               color: white;
               font-weight: 900;
               border-radius: 30px;
               width: 80px;
               height:40px;
               margin-top: 5px;
               margin-left: auto;
               cursor: pointer;
            }
            
            .post__avatar img{
                height: 60px;
                width :80px;
                border-radius: 50%;
            }
            .post__avatar{
                padding-left: 20px;
                padding-top: 10px;
                padding-right: 10px;
                padding-bottom: 10px;
            }
            
            .post{
                display: flex;
                align-items: flex-start;
                border-bottom: 1px solid #ddd;
                padding-bottom: 10px;
            }
            .post__footer{
                /*display: flex;*/
                justify-content: space-between;
                margin-top: 10px;
                padding: 0px 10px;
                display:none;
            }
            
            .post__verified{
                font-size: 14px !important;
                color: #50b7f5;
                margin-right: 5px;
            }
            
            .post__headerIcon{
                font-weight: 600;
                font-size: 16px;
                color:gray;
            }
            
            .post__headerText{
                font-size: 15px;
                margin-bottom: 5px;
            }
            .post__message{
                margin-bottom: 10px;
                font-size: 15px;
            }
            
            .post__body{
                flex: 1;
                padding: 10px;
            }
            
            .material-icons{
                cursor: pointer;
            }
            .post:hover{
                background: rgba(0,0,0,0.03);
                cursor: pointer;
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
            
            
            
        </style>
        
        <script>
            $(document).ready(function(){
                
                $(".tweetbox_postbutton").click(function(){
                    
                    var tweet = $("#tweetbox__input").val(),
                        username = $("#username").text(),
                        full_name = $("#full_name").text(),
                        post_date = "";
                        src = $("#tweetbox_pic").attr("src");
                       
                    if(tweet === ""){
                        
                        alert("Please write something before posting");
                    }
                    
                    else{
                        
                        $.post("Posts",{
                            tweet:tweet
                        },function(date){
                            $(".tweetbox").after($('<div class="post"></div>').append($('<div class="post__avatar"></div>').append('<img src='+src+' alt="avatar"/>'))
                            .append($('<div class="post__body">').append($('<div class="post__header">')
                            .append($('<div class="post__headerText">').append($('<h3>'+full_name+'</h3>').append($('<span class="post__headerIcon">').append('<span class="material-icons post__verified">verified</span>'+username +'&emsp;'+ date))))
                            .append($('<div class="post__message">').append('<p>'+tweet+'</p>')))
                            .append($('<div class="post__footer">').append('<span class="material-icons">repeat</span>','<span class="material-icons">favorite_border</span>','<span class="material-icons">publish</span>'))));
                            
                        });
                         
                    }
                    
                $('#tweetbox__input').val("");});
            });
            
        </script>
    </head>
    
    <body>
        <div class="layout">
            <div class="navbar">
                <img src="./images/NAVBAR.jpg" alt="logo" />
                <div class="nav_options home"><a href="MainPage.jsp"><span class="material-icons home_icon">home</span>Home</a></div>
                <div class="nav_options profile"><a href="MyProfile.jsp"><span class="material-icons profile_icon">person</span>Profile</a></div>
                <div class=" searchwrap"><form id="searchengine" method="post" action="SearchResults.jsp"><input class="searchbar" type="text" name="search" required/><button type="submit" class="searchbtn"><span class="material-icons search">search</span></button></form></div>
                <div class="nav_options logout"><a href="LogOut"><span class="material-icons profile_icon">logout</span>Log Out</a></div>
            </div>
            <div class="feed">
                <div class="tweetbox">
                    <form class="tweetbox__form">
                        <div class="tweetbox__content">
                            <img src=<% out.print(picture); %> alt="avatar" id="tweetbox_pic"/>
                            <input class="tweetbox__input" id="tweetbox__input" type="text" placeholder="What's hapening?"/>
                        </div>  
                        <button class="tweetbox_postbutton" type="button">Post</button>
                    </form>
                </div>
                <div class="post sample">
                    <div class="post__avatar">
                        <img src=<% out.print(picture); %> alt="avatar"/>
                    </div>
                    <div class="post__body">
                        <div class="post__header">
                            <div class="post__headerText">
                                <h3> <p id="full_name"> <% out.print(fname); %> </p> 
                                    <span class="post__headerIcon">
                                        <span class="material-icons post__verified">verified</span><span id="username">@<% out.print(user); %></span>
                                    </span>
                                </h3>
                            </div>
                            <div class="post__message">
                                <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor 
                                    incididunt ut labore et dolore magna aliqua. </p>
                            </div>
                        </div>
                        <div class="post__footer">
                            <span class="material-icons">repeat</span>
                            <span class="material-icons">favorite_border</span>
                            <span class="material-icons">publish</span>
                        </div>
                    </div>
                </div>
                
<% 
    while(result.next()){
        
        
    
%>                    
                <div class="post">
                    <div class="post__avatar">
                        <img src=<% out.print(result.getString("profile_pic")); %> alt="avatar"/>
                    </div>
                    <div class="post__body">
                        <div class="post__header">
                            <div class="post__headerText">
                                <h3><% out.print(result.getString("full_name")); %>
                                    <span class="post__headerIcon">
                                        <span class="material-icons post__verified">verified</span>@<% out.print(result.getString("username")); %> &emsp;<% out.print(result.getString("date")); %>
                                    </span>
                                </h3>
                            </div>
                            <div class="post__message">
                                <p><% out.print(result.getString("message")); %></p>
                            </div>
                        </div>
                        <div class="post__footer">
                            <span class="material-icons">repeat</span>
                            <span class="material-icons">favorite_border</span>
                            <span class="material-icons">publish</span>
                        </div>
                    </div>
                </div>
<%} dao.getCon().close();%>
                                    
            </div>
        </div>
    </body>
</html>
            
<%        }
        else{
            response.sendRedirect("index.html");
        }
    %>

