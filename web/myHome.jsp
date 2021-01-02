<%@ page import="com.jsu.bean.User" %><%--
  Created by IntelliJ IDEA.
  User: Hasee
  Date: 2021/1/2
  Time: 8:05
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
    <link href="css/myHome.css" rel="stylesheet" type="text/css">

    <link rel="stylesheet" type="text/css" href="css/css/sweetalert.css">
    <script src="./js/sweetalert-dev.js"></script>

    <title>我的主页</title>
    <script>
        $(function(){
            $(".glonav>a").click(function(){
                $(".drop-list").slideToggle();
            })
        })
        function exit (){
            location.reload();
        }
        $(document).ready(function(){
            var eClose = document.getElementById('eClose-button');
            eClose.onclick = function close() {
                $("#eBackground").fadeOut();
            }
            $(function(){
                $("#ed").click(function(){
                    $("#eBackground").fadeToggle();
                });
            });
        })
    </script>
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
        <dl class="m-pro f-cb">
            <dt class="f-pr">
                <img src="${SESSION_USER.pic}" >
            </dt>
            <dd>
                <div class="name f-cb">
                    <div class="f-cb">
                        <div class="edit">
                            <button id="ed" type="button">编辑个人资料</button>
                        </div>
                        <h2 class="f-fl">
							<span id="nowName" class="tit">
                              ${SESSION_USER.name}
							</span>
                        </h2>
                    </div>
                </div>
                <div class="riqi">
                    <span>创建日期：&nbsp;<fmt:formatDate value="${SESSION_USER.registerDate}" pattern="yyyy-MM-dd"/> </span>
                </div>
                <div class=" f-cb">
                    <span>生日：&nbsp;<fmt:formatDate value="${SESSION_USER.birthday}" pattern="yyyy-MM-dd"/></span>
                </div>
            </dd>
        </dl>

        <div class="u-title u1">
            <h3>
                <span>我的收藏歌单</span>
            </h3>
        </div>
        <ul class="gedan f-cb">

                <c:if test="${not empty requestScope.myPlayList}" >
                    <c:forEach items="${requestScope.myPlayList}" var="myPlayList">
                    <li>
                        <div class="cover"><a href=""><img src="${myPlayList.pic}" alt=""></a></div>
                        <p style="font-size: 15px;">
                            <a class="tit1" href="">${myPlayList.title}</a>
                        </p>
                    </li>
                    </c:forEach>
                </c:if>

        </ul>
    </div>
</div>

<div>
    <div id="eBackground" >
        <div id="background2" >
            <span id="eClose-button">×</span>
            <div class="verify">
                <div class="verify-form">
                    <div class="verify-login">
                        <div style="height: 100%;">
                            <div id="login-con2">
                                <div class="login-font">
                                    <span id="02" class="cur-choice">名字更新</span>
                                </div>
                                    <div class="form-set">
                                        <label>用户名：</label>
                                        <input type="text" placeholder="请输入新的名称" id="userName" />
                                    </div>
                                    <input style="display:none;" name="email">
                                    <div class="form-set">
                                        <input onclick="updateName()" class="loBtn" type="button" value="确定" />
                                    </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    function updateName(){
        var name=$("#userName").val();
        console.log(name);
        $.ajax({
            url:'UserInfoServlet?method=update2&userId=${SESSION_USER.id}&name='+name,
            type: 'POST',
            dataType: 'text',
            success:function(data){
                if (data=="true"){
                    $("#nowName").html(name);
                    $("#eBackground").fadeOut();
                    swal("更新成功")
                }

            }
        });
    }

</script>


</body>
</html>
