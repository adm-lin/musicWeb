<%@ page import="com.jsu.bean.User" %><%--
  Created by IntelliJ IDEA.
  User: Hasee
  Date: 2020/12/31
  Time: 9:22
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
    <link href="css/songListContent.css" rel="stylesheet" type="text/css">

    <link rel="stylesheet" type="text/css" href="css/css/sweetalert.css">
    <script src="./js/sweetalert-dev.js"></script>

    <title>U享音乐平台</title>
    <script>
        function playSong(id) {
            var src=$(id).children().first().text();

           var play =  document.getElementById('music');
            $('#music').prop('src',src);
            play.play();
           var songName=$(id).children('span').eq(1).text();
            var playCount=$(id).children('span').eq(2).text();
           console.log(songName)
            var rows=id.parentNode.parentNode.rowIndex;

            $.ajax({
                url:'SongInfoServlet?method=updateCount&songName='+songName+'&playCount='+playCount,
                type: 'POST',
                dataType: 'text',
                success:function(data){
                    var count = $("#songListTable tr:eq(" + rows + ") td:eq(2)").html(data);
                    $(id).children('span').eq(2).text(data);
                }
            });
        }

    </script>
    <script type="text/javascript">
        $(function(){
            function time(){
                setInterval(function(){
                    var time1=parseInt(music.currentTime);/*音乐的当前时间*/
                    var time2=parseInt(music.duration);/*音乐的总时间*/
                    var jing=time1/time2*100+"%";
                    $(".progress div").css("width",jing);
                },500);
            }
            time();
        })
        $(function(){
            $(".glonav>a").click(function(){
                $(".drop-list").slideToggle();
            })
        })
        function exit (){
            location.reload();
        }
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

<div class="g-bd4">
    <div class="g-mn4">
        <div class="g-mn4c">
            <div class="g-wrap6">
                <div class="m-info f-cb">
                    <div class="cover">
                        <img src="${requestScope.playList.pic}" alt="">
                    </div>
                    <div class="cnt">
                        <div class="cntc">
                            <div class="hd f-cb">
                                <div class="tit">
                                    <img src="images/li.png" style="float: left;" alt="">
                                    <h2 class="f-ff2 f-brk">${requestScope.playList.title}</h2>
                                </div>
                            </div>
                            <div class="create f-cb">
                                <span><fmt:formatDate value="${requestScope.playList.createDate}" pattern="yyyy-MM-dd"/> 创建</span>
                            </div>
                            <div class="tags f-cb">
                                <b>标签：</b>
                                <i>轻音乐</i>
                            </div>
                            <p>
                                <b>介绍：
                                    穿越古典和流行，带你感受旋律与心灵的共鸣，收录那些最触动我们心扉的唯美钢琴曲</b>
                            </p>
                        </div>
                    </div>
                </div>

                <div class="n-songtb">
                    <div class="u-title fcb">
                        <h3><span>歌曲列表</span></h3>
                    </div>
                    <div>
                        <div>
                            <div>
                                <table class="m-table" id="songListTable">
                                    <thead>
                                    <tr>
                                        <th class="first w1">
                                            <div class="wp">&nbsp;</div>
                                        </th>
                                        <th >歌曲标题</th>
                                        <th>播放量</th>
                                        <th>歌手</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:if test="${not empty requestScope.allSong}" >
                                        <%int i=1;%>
                                        <c:forEach items="${requestScope.allSong}" var="allSong" varStatus="status">
                                                <c:if test="${status.count}>0">
                                                    ${status.count%status.count+1}
                                                </c:if>
                                            <%if (i%2==0){%>
                                                <tr class="even">
                                           <%}else {%>
                                                <tr>
                                            <%}i++;%>
                                            <td >
                                                <span class="ply">&nbsp;</span>
                                                <span>${status.count}</span>
                                            </td>
                                                <td>${allSong.songName}</td>
                                                <td>${allSong.playCount}</td>
                                                <td>${allSong.singerName}
                                                    <a id="boFang" href="javascript:;" onclick="playSong(this)">
                                                    <span style="display: none" id="song-url">${allSong.url}</span>
                                                        <span style="display: none" id="songName">${allSong.songName}</span>
                                                        <span style="display: none" id="count">${allSong.playCount}</span>
                                                    <img style="border-radius: 5px; float: right;" src="images/bo.png" alt="">
                                                </a>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </c:if>

                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="comment">
                    <div class="u-title fcb">
                        <h3><span>评论</span></h3>
                    </div>
                    <div style="height: 180px; margin-top: 10px;">
                        <div class="Input_Box">
                            <textarea id="content" class="Input_text"></textarea>
                            <div class="Input_Foot">
                                <a class="postBtn" onclick="aComment()">发表评论</a>
                            </div>
                        </div>
                    </div>
                    <div class="comment-content">
                        <h4 class="co-h4">精彩评论</h4>
                        <c:if test="${not empty requestScope.allComment}">
                            <c:forEach items="${requestScope.allComment}" var="comment">
                        <div class="com-itm">
                                <div class="head">
                                    <img src=${comment.pic}>
                                </div>
                                <div class="cont">
                                    <div class="specific">
                                        <a href="#">${comment.userName}：</a>
                                        ${comment.content}
                                    </div>
                                    <div class="riqi">
                                        <div class="sp-riqi"><fmt:formatDate value="${comment.commentTime}" pattern="yyyy-MM-dd"/>发表</div>
                                    </div>
                                </div>
                        </div>
                            </c:forEach>
                        </c:if>


                    </div>
                </div>
            </div>
        </div>
    </div>

    <div id="music-play"><!--音乐控制组件-->
        <div id="progress" style="z-index: 10; position: fixed;left: 445px; bottom: 20px;">
            <div class="progress">
                <div id=" progress-tiao" class="progress-bar progress-bar-success" role="progressbar" aria-valuenow="40" aria-valuemin="0" aria-valuemax="100" style="width:  0%">
                </div>
            </div>
        </div>
    </div>

     <div class="broadcast">
    <audio style="outline:none" id="music" src="" controls="controls" autoplay="" loop="loop" preload="auto">
       <%-- <source id="audio-source" src="songs/踏山河.mp3" type='audio/mp3' />--%>
    </audio>
    </div>
</div>
<div class="play">
    <div class="bg-hide">
        <a onclick="collect()" href="javascript:;">
            <b style="margin-left: 45px;margin-top: 15px;display: inline-block">收藏</b>
            <%if (request.getAttribute("favorite")!=null){%>
                <div id="fafa" class="circleOne click"></div>
            <%}else{%>
                <div id="fafa" class="circleOne"></div>
            <%}%>
        </a>
    </div>
</div>
<script>
    function aComment() {
        <%if(user!=null){%>
        var content=$('#content').val();
        console.log(content);
        if (content==""){
            swal("评论不能为空");
        }else {
            $.ajax({
                url:"UserOperateServlet?method=comment&content="+content+"&playListsId="+${requestScope.playList.id},
                type: 'POST',
                dataType: 'text',
                success:function(data){
                    swal('评论成功');
                    location.reload();
                }
            });
        }
        <%}else{%>
        swal('登录U享音乐---可参与评论');
        <%}%>
    }
    function collect(){
        <%if(user!=null){
         %>
        $('#fafa').toggleClass('click');
        var classN=$('#fafa').prop("class");
        console.log(classN)
        var title=$('.f-ff2').text();
        console.log(title)
        if (classN=="circleOne click"){
            $.ajax({
                url:"UserOperateServlet?method=colletList&title="+title+"&userId="+${SESSION_USER.id},
                type: 'POST',
                dataType: 'text',
                success:function(data){
                    swal('收藏歌单成功')
                }
            });
        }else if (classN=="circleOne"){
            $.ajax({
                url:"UserOperateServlet?method=cancelList&title="+title+"&userId="+${SESSION_USER.id},
                type: 'POST',
                dataType: 'text',
                success:function(data){
                    swal('取消收藏')
                }
            });
        }<%}else{%>
        alert('登录U享音乐---享受音乐收藏');
        <%}%>
    }
</script>


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

</body>
</html>
