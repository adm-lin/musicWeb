<%--
  Created by IntelliJ IDEA.
  User: Hasee
  Date: 2020/12/27
  Time: 10:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>U享音乐后台管理</title>
    <link rel="stylesheet" type="text/css" href="css/backStage.css"/>
    <link rel="stylesheet" type="text/css" href="css/css/font-awesome.css"/>
    <script src="./jquery.min.js" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript">

        $(document).ready(function(){
            var open=document.querySelectorAll('.OPEN');
            open[0].onclick=function(){
                console.log(1);
            }
        })
    </script>
</head>
<body>
<div class="main">
    <nav class="nav-white">
        <ul class="nav-bar">
            <li class="nav-right">
                <a href="../musicWeb/adminLogin.jsp" class="nav-link">
                    <span class="nav-font">测试退出</span>
                </a>
            </li>
        </ul>
    </nav>
    <div class="asdie sid-black">
        <a href="javascript:;" class="back-name">
            <img src="../images/u.ico" >
            <span>U享音乐后台管理</span>
        </a>
        <div class="sidebar">
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
                                <a href="javascript:;" class="nav-link" >
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
                                <a href="javascript:;" class="nav-link" >
                                    <i class="fa fa-dot-circle-o"></i>
                                    <p>音乐添加</p>
                                </a>
                            </li>
                            <li class="nav-bb">
                                <a href="javascript:;" class="nav-link active" >
                                    <i class="fa fa-dot-circle-o"></i>
                                    <p>音乐删除</p>
                                </a>
                            </li>
                            <li class="nav-bb">
                                <a href="javascript:;" class="nav-link" >
                                    <i class="fa fa-dot-circle-o"></i>
                                    <p>音乐修改</p>
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
                                <a href="javascript:;" class="nav-link" >
                                    <i class="fa fa-dot-circle-o"></i>
                                    <p>歌单添加</p>
                                </a>
                            </li>
                            <li class="nav-bb">
                                <a href="javascript:;" class="nav-link" >
                                    <i class="fa fa-dot-circle-o"></i>
                                    <p>歌单删除</p>
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
                                <a href="javascript:;" class="nav-link" >
                                    <i class="fa fa-dot-circle-o"></i>
                                    <p>用户添加</p>
                                </a>
                            </li>
                            <li class="nav-bb">
                                <a href="javascript:;" class="nav-link" >
                                    <i class="fa fa-dot-circle-o"></i>
                                    <p>用户删除</p>
                                </a>
                            </li>
                            <li class="nav-bb">
                                <a href="javascript:;" class="nav-link" >
                                    <i class="fa fa-dot-circle-o"></i>
                                    <p>用户修改</p>
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
                                <a href="javascript:;" class="nav-link" >
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

</div>
</body>
</html>

