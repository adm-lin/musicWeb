<%@ page import="com.jsu.bean.User" %><%--
  Created by IntelliJ IDEA.
  User: Hasee
  Date: 2021/1/1
  Time: 10:31
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
    <title>分类</title>
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

<div style="min-height: 1500px" class="g-bd4">
    <div class="g-mn4">
        <div class="g-mn4c">
            <div class="g-wrap6">
                <div class="m-info f-cb">
                    <div class="cover">
                        <img src="images/cute.jpg" alt="">
                    </div>
                    <div class="cnt">
                        <div class="cntc">
                            <div class="hd f-cb">
                                <div class="tit">
                                    <h2 class="f-ff2 f-brk">所有歌曲：愿仲冬的人间烟火, 全都为你馨暖相拥</h2>
                                </div>
                            </div>
                            <div class="tags f-cb">
                                <b>标签：</b>
                                <i>所有音乐</i>
                            </div>
                            <p>
                                <b>介绍：不同的乐队 ，不同的歌手 ，不同的声音 ，不客观目录</b>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="classify f-cb">
                    <div class="cnt">
                        <div class="cntc">
                            <div class="hd f-cb">
                                <div class="tit">
                                    <h2 class="f-ff2 f-brk">
                                        音乐类型
                                        <a style="font-size: 20px; margin-left: 50px; color: darkorange;" href="/musicWeb/ClassifyServlet?method=allSong">全部歌曲</a>
                                    </h2>
                                </div>
                            </div>
                            <div class="tags f-cb">
                                <a href="/musicWeb/ClassifyServlet?method=classify&type=粤语"><b>粤语</b></a>
                                <a href="/musicWeb/ClassifyServlet?method=classify&type=动漫"><b>动漫</b></a>
                                <a href="/musicWeb/ClassifyServlet?method=classify&type=DJ"><b>DJ</b></a>
                                <a href="/musicWeb/ClassifyServlet?method=classify&type=情歌"><b>情歌</b></a>
                                <a href="/musicWeb/ClassifyServlet?method=classify&type=故事"><b>故事</b></a>
                                <a href="/musicWeb/ClassifyServlet?method=classify&type=风采"><b>风采</b></a>
                                <a href="/musicWeb/ClassifyServlet?method=classify&type=合唱"><b>合唱</b></a>
                                <a href="/musicWeb/ClassifyServlet?method=classify&type=现代"><b>现代</b></a>
                            </div>
                            <div class="tags f-cb">
                                <a href="/musicWeb/ClassifyServlet?method=classify&type=古典"><b>古典</b></a>
                                <a href="/musicWeb/ClassifyServlet?method=classify&type=流行"><b>流行</b></a>
                                <a href="/musicWeb/ClassifyServlet?method=classify&type=摇滚"><b>摇滚</b></a>
                                <a href="/musicWeb/ClassifyServlet?method=classify&type=管弦乐"><b>管弦乐</b></a>
                                <a href="/musicWeb/ClassifyServlet?method=classify&type=民谣"><b>民谣</b></a>
                                <a href="/musicWeb/ClassifyServlet?method=classify&type=翻唱"><b>翻唱</b></a>

                            </div>
                        </div>
                    </div>
                </div>

                <div class="n-songtb">
                    <div class="u-title fcb">
                        <h3><span>歌曲列表</span></h3>
                    </div>
                    <div>
                        <div>
                            <div style="overflow-y: scroll; max-height: 700px;">
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
        </audio>
    </div>
</div>
<div class="play">
    <div class="bg-hide">
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
