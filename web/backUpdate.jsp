<%--
  Created by IntelliJ IDEA.
  User: Hasee
  Date: 2020/12/27
  Time: 16:21
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="app.jsp"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>U享音乐后台管理</title>
    <link rel="stylesheet" type="text/css" href="css/backUpdate.css"/>
    <link rel="stylesheet" type="text/css" href="css/css/font-awesome.css"/>
    <script src="js/jquery-3.3.1.min.js"></script>
    <script type="text/javascript">
        function jump() {
        console.log(1);
        top.location.href='home.jsp';
    }
    </script>
</head>
<body>
<%
    if(session.getAttribute("SESSION_ADMIN") == null) {
%>
<script type="text/javascript" language="javascript">
    alert("您还没有登录，请登录...");
    top.location.href="adminLogin.jsp";
</script>
<%
    }else {
%>
<div class="main">
    <nav class="nav-white">
        <ul class="nav-bar">
            <li class="nav-right">
                <a href="javascript:void(0);" onclick="jump()" class="nav-link">
                <span class="nav-font">返回主页</span>
                </a>
            </li>
        </ul>
    </nav>
    <div class="asdie sid-black">
        <a href="javascript:;" class="back-name">
            <img src="images/u.ico" >
            <span>U享音乐后台管理</span>
        </a>

        <div class="sidebar">
            <div class="pan">
                <div class="image-info">
                    <img src="images/zba1.png" class="cic" >
                </div>
                <div class="name-info">
                    <a href="javascript:;">林宇驹</a>
                </div>
            </div>
            <nav>
                <ul class="flx-co">

                    <li class="nav-bb">
                        <a href="javascript:;" class="nav-link active">
                            <i class="fa fa-check-square"></i>
                            <p >
                                密码管理
                                <i class="fa fa-angle-left right" ></i>
                            </p>
                        </a>
                        <ul class="nav-child" >
                            <li class="nav-bb">
                                <a href="../musicWeb/backUpdate.jsp" class="nav-link active" >
                                    <i class="fa fa-dot-circle-o"></i>
                                    <p>修改密码</p>
                                </a>
                            </li>
                        </ul>
                    </li>
                    <li  class="nav-bb">
                        <a id="1" href="javascript:;" class="nav-link active">
                            <i class="fa fa-check-square"></i>
                            <p >
                                音乐管理
                                <i class="fa fa-angle-left right" ></i>
                            </p>
                        </a>
                        <ul class="nav-child ">
                            <li class="nav-bb">
                                <a href="/musicWeb/SongInfoServlet?method=songList" class="nav-link" >
                                    <i class="fa fa-dot-circle-o"></i>
                                    <p>音乐编辑</p>
                                </a>
                            </li>
                        </ul>
                    </li>
                    <li class="nav-bb">
                        <a href="javascript:;" class="nav-link active">
                            <i class="fa fa-check-square"></i>
                            <p >
                                歌单管理
                                <i class="fa fa-angle-left right" ></i>
                            </p>
                        </a>
                        <ul class="nav-child" >
                            <li class="nav-bb">
                                <a href="/musicWeb/PlayListInfoServlet?method=playList" class="nav-link" >
                                    <i class="fa fa-dot-circle-o"></i>
                                    <p>歌单编辑</p>
                                </a>
                            </li>
                        </ul>
                    </li>
                    <li class="nav-bb">
                        <a href="javascript:;" class="nav-link active">
                            <i class="fa fa-check-square"></i>
                            <p >
                                用户管理
                                <i class="fa fa-angle-left right" ></i>
                            </p>
                        </a>
                        <ul class="nav-child" >
                            <li class="nav-bb">
                                <a href="/musicWeb/UserInfoServlet?method=userList" class="nav-link" >
                                    <i class="fa fa-dot-circle-o"></i>
                                    <p>用户编辑</p>
                                </a>
                            </li>

                        </ul>
                    </li>
                    <li class="nav-head">OTHERS</li>
                    <li class="nav-bb">
                        <a href="javascript:;" class="nav-link active">
                            <i class="fa fa-check-square"></i>
                            <p >
                                其他选项
                                <i class="fa fa-angle-left right" ></i>
                            </p>
                        </a>
                        <ul class="nav-child" >
                            <li class="nav-bb">
                                <a href="javascript:;" class="nav-link" >
                                    <i class="fa fa-dot-circle-o"></i>
                                    <p>1</p>
                                </a>
                            </li>
                            <li class="nav-bb">
                                <a href="javascript:;" class="nav-link" >
                                    <i class="fa fa-dot-circle-o"></i>
                                    <p>2</p>
                                </a>
                            </li>
                            <li class="nav-bb">
                                <a href="/musicWeb/AdminLoginServlet?method=exit" class="nav-link" >
                                    <i class="fa fa-dot-circle-o"></i>
                                    <p>退出系统</p>
                                </a>
                            </li>

                        </ul>
                    </li>
                    <li class="nav-head">INTRODUCTION</li>
                    <li class="nav-bb">
                        <a href="javascript:;" class="nav-link active">
                            <i class="fa fa-check-square"></i>
                            <p >
                                信息介绍
                                <i class="fa fa-angle-left right" ></i>
                            </p>
                        </a>
                        <ul class="nav-child" >
                            <li class="nav-bb">
                                <a href="javascript:;" class="nav-link" >
                                    <i class="fa fa-dot-circle-o"></i>
                                    <p>1</p>
                                </a>
                            </li>
                            <li class="nav-bb">
                                <a href="javascript:;" class="nav-link" >
                                    <i class="fa fa-dot-circle-o"></i>
                                    <p>2</p>
                                </a>
                            </li>
                            <li class="nav-bb">
                                <a href="javascript:;" class="nav-link" >
                                    <i class="fa fa-dot-circle-o"></i>
                                    <p>3</p>
                                </a>
                            </li>

                        </ul>
                    </li>
                </ul>
            </nav>

        </div>
    </div>

    <div class="content-wrap" style="min-height: 1200px;">
        <section class="content-head">
            <div class="chead-in">
                <div class="row">
                    <div class="col1">
                        <h1>密码修改</h1>
                    </div>
                </div>
            </div>
        </section>
        <section class="content">
            <div class="chead-in">
                <div class="row">
                    <div class="col">
                        <div class="card">
                            <div class="card-head">
                                <h3>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;密码修改</h3>
                            </div>
                            <form action="/musicWeb/AdminReviseServlet" method="post">
                                <div class="card-bo">
                                    <div class="fgroup">
                                        <label>账户：</label>
                                        <input class="fgroup-input" type="text" name="adAccount"  value="" />
                                    </div>
                                    <div class="fgroup">
                                        <label>原密码：</label>
                                        <input class="fgroup-input" type="password" name="adPassword"  value="" />
                                    </div>
                                    <div class="fgroup">
                                        <label>修改密码：</label>
                                        <input class="fgroup-input" type="password" name="adAfterPassword"  value="" />
                                    </div>
                                </div>
                                <div class="card-fo">
                                    <button type="submit" value="">确定</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </div>
</div>
<%
    }
%>
</body>
</html>

