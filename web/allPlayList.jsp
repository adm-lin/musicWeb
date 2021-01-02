<%@ page import="com.jsu.bean.User" %><%--
  Created by IntelliJ IDEA.
  User: Hasee
  Date: 2021/1/2
  Time: 11:01
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="app.jsp"%>
<%
    User user= (User) session.getAttribute("SESSION_USER");
%>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
    <script src="js/jquery-3.3.1.min.js"></script>
    <script>window.jQuery || document.write('<script src="js/jquery-3.3.1.min.js"><\/script>')</script>
    <script src="https://cdn.bootcss.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <script src="js/holder.min.js"></script>
    <script src="js/ie10-viewport-bug-workaround.js"></script>
    <link href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
    <link href="css/css/ie10-viewport-bug-workaround.css" rel="stylesheet">
    <link href="css/css/font-awesome.css" rel="stylesheet" type="text/css">
    <script src="js/ie-emulation-modes-warning.js"></script>
    <link href="css/allPlayList.css" rel="stylesheet" type="text/css">

    <link rel="stylesheet" type="text/css" href="css/css/sweetalert.css">
    <script src="./js/sweetalert-dev.js"></script>
    <title>所有歌单</title>
    <script>
        $(function(){
            var btn = document.getElementById('login');
            var close = document.getElementById('close-button');

            btn.onclick = function show() {
                $("#background").fadeToggle();
                console.log(1);
            }

            close.onclick = function close() {
                $("#background").fadeOut();
            }
            document.getElementById('01').onclick=function(){
                $('#01').addClass('cur-choice');
                $('#02').removeClass('cur-choice');
                $('#hook1').addClass('hook');
                $('.loBtn').attr("value","登录")
                $('#form1').attr("action","/musicWeb/UserLoginServlet")
            }
            document.getElementById('02').onclick=function(){
                $('#01').removeClass('cur-choice');
                $('#02').addClass('cur-choice');
                $('.loBtn').attr("value","注册");
                $('#form1').attr("action","/musicWeb/UserRegisterServlet")
                $('#hook1').removeClass('hook');
            }
            $(function(){
                $('#accept').click(function(){
                    var domName = $(this).attr('name');
                    var radio = $(this);
                    if (radio.data('waschecked') == true){
                        radio.prop('checked', false);
                        $("input:radio[name='" + domName + "']").data('waschecked',false);
                    } else {
                        radio.prop('checked', true);
                        $("input:radio[name='" + domName + "']").data('waschecked',false);
                        radio.data('waschecked', true);
                    }
                });
            });
        })

        function ISchange() {
            var action=$('#form1').attr('action');
            if(action=='/musicWeb/UserRegisterServlet'){
                return validate();
            }else{
                return true;
            }
        }
        function validate() {
            var email =document.getElementById("email").value;
            var password =document.getElementById("password").value;
            var accept=$('#accept').prop('checked');

            //验证邮箱合法性
            var pattern=/^([a-zA-Z]|[0-9])(\w|\-)+@[a-zA-Z0-9]+\.([a-zA-Z]{2,4})$/;
            if(email==''){
                alert("email不能为空");
                return false;
            }else if(!pattern.test(email)){
                alert("email格式不正确");
                return false;
            }
            if(password==''){
                alert("password不能为空");
                return false;
            }else if(password.length<6 || password.length>12){
                alert("密码长度在6-12字符之间");
                return false;
            }
            if(accept==false){
                alert("请勾选是否同意注册选项");
                return false;
            }
            return true;
        }
        $(function(){
            $(".glonav>a").click(function(){
                $(".drop-list").slideToggle();
            })
        })
        function exit (){
            location.reload();
        }
    </script>
    <style type="text/css">
        .listUl{
            margin: 20px 0 0 -40px;
            padding: 0;
        }
        .listUl:after{
            clear: both;
            content: '.';
            display: block;
            height: 0;
            visibility: hidden;
        }
        .listUl li{
            width: 200px;
            height: 200px;
            padding-left: 42px;
        }
        .listUl li{
            float: left;
            display: inline-block;
            overflow: hidden;
            padding: 0 0 30px 50px;
            line-height: 1.4;
        }
        .listUl li .list-p{
            margin: 8px 0 3px;
            font-size: 14px;
        }
        .listUl li .list-a{
            display: inline-block;
            max-width: 100%;
            vertical-align: middle;
            color: black;
        }
    </style>
</head>
<body>
<nav class="navbar navbar-default navbar-fixed-top">
    <div class="container">
        <div class="navbar-header">
            <a style="font-size: 30px" class="navbar-brand" href="#">U享音乐</a>
            <span>CHINA</span>
        </div>
        <div style="margin-top: 10px;" id="navbar" class="navbar-collapse collapse">
            <ul class="nav navbar-nav">
                <li ><a href="/musicWeb/top2.jsp">发现音乐</a></li>
                <li><a href="https://www.baidu.com/">咨询</a></li>
                <li><a href="#contact">我的收藏</a></li>
            </ul>
            <ul class="nav navbar-nav navbar-right">
                <li><form class="navbar-form navbar-left" role="search">
                    <div class="form-group">
                        <input type="text" class="form-control" placeholder="Search">
                    </div>
                </form></li>
                <%if(user!=null){
                    System.out.println(user.getName());
                %>
                <li class="glonav">
                    <a  href="javascript:;">${SESSION_USER.name}</a>
                    <ul class="drop-list">
                        <li><a href="/musicWeb/UserOperateServlet?method=myHome&userId=${SESSION_USER.id}">我的主页</a></li>
                        <li><a onclick="exit()" id="exit" href="/musicWeb/UserLoginServlet?method=exit">退出</a></li>
                    </ul>
                </li>
                <%	}else{%>
                <li><a id="login" href="javascript:;">登录/注册</a></li>
                <%}%>
                <li ><a href="/musicWeb/backUpdate.jsp">后台 </a></li>
            </ul>
        </div>
    </div>
</nav>

<div class="g-bd">
    <div class="g-wrap p-prf">
        <div class="u-title u1">
            <h3>
                <span>所有歌单</span>
            </h3>
        </div>
        <ul id="playlist" class="listUl">
            <c:if test="${not empty requestScope.allPlayLists}" >
                <c:forEach items="${requestScope.allPlayLists}" var="list">
                    <li>
                        <div class="list list-1">
                            <%if(user!=null){%>
                            <a href="javaScript:{location.href='/musicWeb/ShowPlayListServlet?ids=${list.title}&userId=${SESSION_USER.id}'}" name="title" class="msk">
                                <img style="width:150px;height: 150px;border: 2px solid black" src="${list.pic}" alt="">
                            </a>
                            <%	}else{%>
                            <a href="javaScript:{location.href='/musicWeb/ShowPlayListServlet?ids=${list.title}'}" name="title" class="msk"><img style="width:150px;height: 150px;border: 2px solid black" src="${list.pic}" alt=""></a>
                            <%}%>
                        </div >
                        <p class="list-p">
                            <a href="#" class="list-a">${list.title}</a>
                        </p>
                    </li>
                </c:forEach>
            </c:if>
        </ul>
    </div>
</div>

<div>
    <div id="background" >
        <div id="background1" >
            <span id="close-button">×</span>
            <div class="verify">
                <div class="verify-form">
                    <div class="verify-pic">
                        <img src="../images/musicPic.png" style="display: none;">
                    </div>
                    <div class="verify-login">
                        <div style="height: 100%;">
                            <div id="login-con">
                                <div class="login-font">
                                    <span id="01" class="cur-choice">账户登录</span>
                                    <span id="02" class>账户注册</span>
                                </div>

                                <form id="form1" action="/musicWeb/UserLoginServlet" method="get" name="login" onsubmit="return ISchange()">
                                    <div class="form-set">
                                        <label>邮箱：</label>
                                        <input id="email" type="text" placeholder="请输入邮箱" name="email" />
                                        <label style="color: red;font-size: 15px;"></label>
                                    </div>
                                    <div class="form-set">
                                        <label>密码：</label>
                                        <input id="password" type="password" placeholder="请输入密码" name="password" />
                                    </div>
                                    <div id="hook1" class="form-set hook">
                                        <input style="vertical-align: middle; height: 25px; width: 20px;" type="radio" name="" id="accept"/>
                                        <span style="vertical-align: middle;">同意注册</span>
                                    </div>
                                    <div class="form-set">
                                        <input class="loBtn" type="submit" value="登录" />
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>


</body>
</html>
