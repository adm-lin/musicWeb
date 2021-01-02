<%--
  Created by IntelliJ IDEA.
  User: Hasee
  Date: 2020/12/28
  Time: 8:52
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="app.jsp"%>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <title>U享音乐后台管理</title>
    <link rel="stylesheet" type="text/css" href="css/playListCompile.css"/>
    <link rel="stylesheet" type="text/css" href="css/css/font-awesome.css"/>
    <script src="js/jquery-3.3.1.min.js"></script>
    <script>
        $(document).ready(function(){
            var btn = document.getElementById('add');
            var btn1 = document.getElementById('add1');
            var close = document.getElementById('close-button');
            var eClose = document.getElementById('eClose-button');
            var aClose = document.getElementById('aClose-button');

            btn1.onclick = function show() {
                $("#aBackground").fadeToggle();
            }

            btn.onclick = function show() {
                $("#background").fadeToggle();
            }

            close.onclick = function close() {
                $("#background").fadeOut();
            }
            eClose.onclick = function close() {
                $("#eBackground").fadeOut();
            }
            aClose.onclick = function close(){
                $("#aBackground").fadeOut();
            }
            $(function(){
                $("[id=ed]").click(function(){
                    $("#eBackground").fadeToggle();
                });
            });
        })
        function beforePage(page) {

            window.location="${appPath}/PlayListInfoServlet?method=playList&currentPage="+page+"&pageSize=${requestScope.page.pageSize}";
        }
        function afterPage(page) {
            window.location="${appPath}/PlayListInfoServlet?method=playList&currentPage="+page+"&pageSize=${requestScope.page.pageSize}";
        }
        function editTable(id){
            var rows = id.parentNode.parentNode.rowIndex;
            var title = $(".dadaTable tr:eq(" + rows + ") td:eq(1)").html()
            $("#form2 [name=beforeName]").val(title)
            $("#form2 [name=title]").val(title)

        }

        function jump() {
            console.log(1);
            top.location.href='home.jsp';
        }
        function selSong (selObj) {

            var rows = selObj.parentNode.parentNode.rowIndex;
            var title = $(".dadaTable tr:eq(" + rows + ") td:eq(1)").html()
            $("#form3 [name=title]").val(title);
            $.ajax({
                url:'SongInfoServlet?type=ajax&method=songList&title='+title,
                type: 'POST',
                dataType: 'json',
                success:function(data){
                    var jslength=0;
                    for(var js2 in data){
                        jslength++;
                    }
                    $('#songNum').html("共"+jslength+"首歌")
                    var tbody = $("#songTb");
                    tbody.empty();
                    for (var num=0;num<jslength;num++){
                        var tr= $("<tr></tr>");
                        tr.append($("<td>" + (num + 1) + "</td>"))
                        tr.append($("<td>" + (data[num].songName) + "</td>"));
                        tr.append($("<td>" + (data[num].singerName) + "</td>"));
                        tr.append($("<td>" + (data[num].url) + "</td>"));
                        tr.append($("<td>" + (data[num].type) + "</td>"));
                        tr.append($("<td>" + (data[num].playCount) + "</td>"));
                        tr.appendTo(tbody);
                    }
                }
            });
        }
    </script>
</head>
<body>
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
                                <a href="../musicWeb/backUpdate.jsp" class="nav-link " >
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
                                <a href="/musicWeb/SongInfoServlet?method=songList" class="nav-link " >
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
                                <a href="/musicWeb/PlayListInfoServlet?method=playList" class="nav-link active" >
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
                                <a href="/musicWeb/UserInfoServlet?method=userList" class="nav-link " >
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
                        <h1>歌单编辑</h1>
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
                                <h3>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;歌单编辑</h3>
                            </div>
                            <div class="card-bo">
                                <div class="Table">
                                    <div class="row">
                                        <div class="col"></div>
                                        <div class="col">
                                            <button class="ba" type="submit" id="add">新增</button>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col">
                                            <table class="dadaTable">
                                                <thead>
                                                <tr role="row">
                                                    <th  class=" ttr">
                                                        ID
                                                    </th>
                                                    <th  class=" ttr">
                                                        歌单名
                                                    </th>
                                                    <th  class=" ttr">
                                                        图片
                                                    </th>
                                                    <th  class=" ttr">
                                                        创建时间
                                                    </th>
                                                    <th  class=" ttr">
                                                        操作
                                                    </th>
                                                </tr>
                                                </thead>
                                                <tbody >
                                                <c:if test="${not empty requestScope.playPage.list}" >
                                                    <c:forEach items="${requestScope.playPage.list}" var="play" varStatus="status">
                                                        <tr>
                                                            <c:if test="${status.count}>0">
                                                                ${status.count%status.count+1}
                                                            </c:if>
                                                            <td>${status.count}</td>
                                                            <td>${play.title}</td>
                                                            <td><img style="width: 100px;height: 100px;" src="${play.pic}"></td>
                                                            <td><fmt:formatDate value="${play.createDate}" pattern="yyyy-MM-dd"/></td>
                                                            <td>
                                                                <button type="button" id="ed"  onclick="editTable(this)">编辑</button>
                                                                <button type="button" id="sel" onclick="selSong(this)">查看</button>
                                                            </td>
                                                        </tr>
                                                    </c:forEach>
                                                </c:if>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col2">
                                            <div style="padding-top: 0.85em; white-space: nowrap;">共${requestScope.playPage.totalPages}页，共${requestScope.playPage.totalRows}个歌单</div>
                                        </div>
                                        <div class="col3">
                                            <div style=" margin: 0; text-align: right; white-space: nowrap;">
                                                <ul class="Boption">
                                                    <li >
                                                        <a style="margin-left: 0; border-radius: 5px 0 0 5px;" class="page-link" href="javascript:beforePage(${requestScope.playPage.beforePage})">上一页</a>
                                                    </li>
                                                    <c:forEach var="num" begin="1" end="${requestScope.playPage.totalPages}">
                                                        <li><a class="page-link" href="">${num}</a></li>
                                                    </c:forEach>
                                                    <li >
                                                        <a style="border-radius: 0 5px 5px 0;" class="page-link" href="javascript:afterPage(${requestScope.playPage.afterPage})">下一页</a>
                                                    </li>
                                                </ul>
                                            </div>

                                        </div>
                                    </div>

                                </div>
                            </div>
                        </div>
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
                                <h3>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;歌单歌曲</h3>
                            </div>
                            <div class="card-bo">
                                <div class="Table">
                                    <div class="row">
                                        <div class="col"></div>
                                        <div class="col">
                                            <button class="ba" type="submit" id="add1">新增</button>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col" style="overflow-y: scroll;height: 400px;">
                                            <table  class="dadaTable" >
                                                <thead>
                                                <tr role="row">
                                                    <th  class=" ttr">
                                                        ID
                                                    </th>
                                                    <th  class=" ttr">
                                                        歌曲名称
                                                    </th>
                                                    <th  class=" ttr">
                                                        歌手
                                                    </th>
                                                    <th  class=" ttr">
                                                        歌曲地址
                                                    </th>
                                                    <th  class=" ttr">
                                                        类型
                                                    </th>
                                                    <th  class=" ttr">
                                                        播放量
                                                    </th>

                                                </tr>
                                                </thead>
                                                <tbody id="songTb">
                                                <tr>
                                                </tr>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col2">
                                            <div id="songNum" style="padding-top: 0.85em; white-space: nowrap;">共首歌</div>
                                        </div>
                                    </div>

                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </div>
    <div>
        <div id="background" >
            <div id="background1" >
                <span id="close-button">×</span>
                <div class="verify">
                    <div class="verify-form">
                        <div class="verify-login">
                            <div style="height: 100%;">
                                <div id="login-con">
                                    <div class="login-font">
                                        <span id="01" class="cur-choice">歌单新增</span>
                                    </div>
                                    <form id="form1" action="/musicWeb/PlayListInfoServlet?method=add" enctype="multipart/form-data" method="post">
                                        <div class="form-set">
                                            <label>歌单名：</label>
                                            <input type="text" placeholder="请输入歌单名" name="title" />
                                        </div>
                                        <div class="form-set">
                                            <label>歌单图片：</label>
                                            <input type="file"  name="pic" />
                                        </div>
                                        <div class="form-set">
                                            <input class="loBtn" type="submit" value="确定" />
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

    <div>
        <div id="aBackground" >
            <div id="aBackground1" >
                <span id="aClose-button">×</span>
                <div class="verify">
                    <div class="verify-form">
                        <div class="verify-login">
                            <div style="height: 100%;">
                                <div id="login-con3">
                                    <div class="login-font">
                                        <span id="03" class="cur-choice">歌曲新增</span>
                                    </div>
                                    <form id="form3" action="/musicWeb/PlayListInfoServlet?method=songAdd" enctype="multipart/form-data" method="post">
                                        <input style="display: none" name="title">
                                        <div class="form-set">
                                            <label>歌名：</label>
                                            <input type="text" placeholder="请输入歌名" name="songName" />
                                        </div>
                                        <div class="form-set">
                                            <label>歌手：</label>
                                            <input type="text" placeholder="请输入歌手名" name="singerName" />
                                        </div>
                                        <div class="form-set">
                                            <label>类型：</label>
                                            <input type="text" placeholder="请输入类型" name="type" />
                                        </div>
                                        <div class="form-set">
                                            <label>歌曲地址：</label>
                                            <input type="file"  name="url" />
                                        </div>
                                        <div class="form-set">
                                            <input class="loBtn" type="submit" value="确定" />
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
                                        <span id="02" class="cur-choice">歌单编辑</span>
                                    </div>
                                    <form id="form2" action="/musicWeb/PlayListInfoServlet?method=update" method="post">
                                        <input style="display: none" name="beforeName">
                                        <div class="form-set">
                                            <label>歌单名：</label>
                                            <input type="text" placeholder="请输入歌单名" name="title" />
                                        </div>
                                        <div class="form-set">
                                            <input class="loBtn" type="submit" value="确定" />
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


</div>
</body>
</html>