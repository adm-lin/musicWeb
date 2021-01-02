<%@ page import="com.jsu.bean.User" %>
<%@ page import="java.util.Random" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Hasee
  Date: 2020/12/25
  Time: 14:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="app.jsp"%>
<html>
<head>
    <%
        User user= (User) session.getAttribute("SESSION_USER");
    %>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>头部</title>
    <link href="css/top.css" rel="stylesheet" type="text/css" />
    <script src="js/jquery-3.3.1.min.js"></script>
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
    </script>

</head>
<body>
<div id="top">
    <header id="header" class="setcenter">
        <div class="logo">
            <a style=" text-decoration: none; color: blue" href="">U享音乐</a>
            <span>CHINA</span>
        </div>
    </header>
    <div class="aaa">
        <div>
            <ul id="globalNav">
                <li>
                    <a href="">发现音乐</a>
                </li>
                <li>
                    <a href="">我的歌单</a>
                </li>
                <li>
                    <a href="">咨询</a>
                </li>
                <li>
                    <a href="">我的收藏</a>
                </li>
                <li>
                    <a href="">下载客户端</a>
                </li>
            </ul>
            <div class="in">
                <input placeholder="搜索" type="search"/>
                <%if(user!=null){
                    System.out.println(user.getName());
                %>
                    <a>${SESSION_USER.name}</a>
                <%	}else{%>
                    <a id="login" href="javascript:;">登录/注册</a>
                <%}%>
                <a href="/musicWeb/backUpdate.jsp">后台</a>
            </div>
        </div>
    </div>
</div>

<div class="mtop"></div>
<div class="caro">
    <div class="wrap">
        <iframe src="carousel.html"></iframe>
    </div>
</div>
<div class="mContent">
    <div class="mg">
        <div class="mg-left">
            <div class="wrap3">
                <div class="recom">
                    <div class="re-h">
                        <a href="" class="re-title">热门推荐</a>
                    </div>
                    <h1><a href="top2.jsp">首页2</a></h1>
                    <ul id="playlist" class="listUl">
                        <c:if test="${not empty sessionScope.playPage.list}" >
                            <c:forEach items="${sessionScope.playPage.list}" var="list" varStatus="status">
                                <li>
                                    <div class="list list-1">
                                        <img style="border: 1px solid black" src="${list.pic}" alt="">
                                        <a href="#" class="msk"></a>
                                        <div class="l-bottom">
                                            <a href="#" class="play-icon"></a>
                                            <span class="l-sp"><%=new Random().nextInt(50)+1%>w</span>
                                        </div>
                                    </div >

                                    <p class="list-p">
                                        <a href="#" class="list-a">${list.title}</a>
                                    </p>
                                </li>
                            </c:forEach>
                        </c:if>
                    </ul>
                </div>
                <div style="position: relative;margin: 0 0 35px;"></div>
                <div class="Sbill">
                    <div class="re-h">
                        <a href="" class="re-title">歌曲榜</a>
                    </div>
                    <div class="songBlist">
                        <dl class="bl">
                            <dt class="bl-top">
                                <div class="bl-img">
                                    <img src="images/newSong.jpg" alt="">
                                </div>
                                <div class="tit">
                                    <a href="#">
                                        <h3>新歌榜</h3>
                                    </a>
                                </div>
                            </dt>
                            <dd>
                                <ol>
                                    <li><a href=""><span class="no" style="color:red;">1</span>过过过</a></li>
                                    <li><a href=""><span class="no">1</span>过过过</a></li>
                                    <li><a href=""><span class="no">1</span>过过过</a></li>
                                    <li><a href=""><span class="no">1</span>过过过</a></li>
                                    <li><a href=""><span class="no">1</span>过过过</a></li>
                                    <li><a href=""><span class="no">1</span>过过过</a></li>
                                    <li><a href=""><span class="no">1</span>过过过</a></li>
                                </ol>
                            </dd>
                        </dl>
                        <dl class="bl">
                            <dt class="bl-top">
                                <div class="bl-img">
                                    <img src="images/surge.jpg" alt="">
                                </div>
                                <div class="tit">
                                    <a href="#">
                                        <h3>飙升榜</h3>
                                    </a>
                                </div>
                            </dt>
                            <dd>
                                <ol>
                                    <li><a href=""><span class="no" style="color:red;">1</span>过过过</a></li>
                                    <li><a href=""><span class="no">1</span>过过过</a></li>
                                    <li><a href=""><span class="no">1</span>过过过</a></li>
                                    <li><a href=""><span class="no">1</span>过过过</a></li>
                                    <li><a href=""><span class="no">1</span>过过过</a></li>
                                    <li><a href=""><span class="no">1</span>过过过</a></li>
                                    <li><a href=""><span class="no">1</span>过过过</a></li>
                                </ol>
                            </dd>
                        </dl>

                    </div>
                </div>

            </div>
        </div>
    </div>
    <div class="mg2">
        <div>
            <div class="userNota">
                <p class="note">登录U享音乐，可以享受无限收藏的乐趣</p>
            </div>
        </div>
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
