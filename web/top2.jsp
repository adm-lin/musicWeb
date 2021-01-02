<%@ page import="com.jsu.bean.User" %>
<%@ page import="java.util.Random" %>
<%--
  Created by IntelliJ IDEA.
  User: Hasee
  Date: 2020/12/30
  Time: 20:54
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
    <link href="css/top2.css" rel="stylesheet" type="text/css">
    <title>U享音乐平台</title>

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
                <li ><a href="#">发现音乐</a></li>
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

<div id="myCarousel" class="carousel slide" data-ride="carousel">
    <!-- Indicators -->
    <ol class="carousel-indicators">
        <li data-target="" data-slide-to="0" class="active"></li>
        <li data-target="" data-slide-to="1"></li>
        <li data-target="" data-slide-to="2"></li>
        <li data-target="" data-slide-to="3"></li>
        <li data-target="" data-slide-to="4"></li>
    </ol>
    <div class="carousel-inner" role="listbox">
        <div class="item active">
            <img class="first-slide" src="images/1.jpg" alt="First slide">
            <div class="container">
                <div class="carousel-caption">
                </div>
            </div>
        </div>
        <div class="item">
            <img class="second-slide" src="images/2.jpg" alt="Second slide">
            <div class="container">
                <div class="carousel-caption">
                </div>
            </div>
        </div>
        <div class="item">
            <img class="third-slide" src="images/3.jpg" alt="Third slide">
            <div class="container">
                <div class="carousel-caption">
                </div>
            </div>
        </div>
        <div class="item">
            <img class="third-slide" src="images/4.jpg" alt="Four slide">
            <div class="container">
                <div class="carousel-caption">
                </div>
            </div>
        </div>
        <div class="item">
            <img class="third-slide" src="images/5.jpg" alt="Five slide">
            <div class="container">
                <div class="carousel-caption">
                </div>
            </div>
        </div>
    </div>
    <a class="left carousel-control" href="#myCarousel" role="button" data-slide="prev">
        <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
        <span class="sr-only">Previous</span>
    </a>
    <a class="right carousel-control" href="#myCarousel" role="button" data-slide="next">
        <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
        <span class="sr-only">Next</span>
    </a>
</div>


<div class="container marketing">

    <div class="row">
        <div class="col-lg-4">
            <img class="img-circle" src="images/singer/luo.jpg" alt="Generic placeholder image" width="140" height="140">
            <h2>罗志祥</h2>
            <p>罗志祥的《罗生门》是2010年台湾地区的年度唱片销售总冠军。在戏剧发展上，罗志祥亦凭《海派甜心》，获金钟奖提名戏剧节目男主角奖项。2010年5月《舞法舞天》第二次世界巡回演唱会于香港红磡体育馆正式开跑。</p>
            <p><a class="btn btn-default" href="#" role="button">查看更多 &raquo;</a></p>
        </div><!-- /.col-lg-4 -->
        <div class="col-lg-4">
            <img class="img-circle" src="images/singer/chen.jpg" alt="Generic placeholder image" width="140" height="140">
            <h2>陈奕迅</h2>
            <p>1997年，发行个人首张国语专辑《一滴眼泪》；4月12日，发行粤语专辑《与我常在》，同名主打歌获得第20届十大中文金曲颁奖典礼最佳创作歌曲奖；同年，主演个人首部电影《旺角大家姐》。</p>
            <p><a class="btn btn-default" href="#" role="button">查看更多 &raquo;</a></p>
        </div>
        <div class="col-lg-4">
            <img  class="img-circle" src="images/singer/han.jpg" alt="Generic placeholder image" width="140" height="140">
            <h2>韩红</h2>
            <p>韩红，全国政协委员，华录百纳娱乐公司董事长兼CEO、音乐人、慈善家、导演、主持人“有宠集团”联合创始人执行董事， 先后毕业于中国音乐学院 、解放军艺术学院中共中央党校研究生。</p>
            <p><a class="btn btn-default" href="#" role="button">查看更多 &raquo;</a></p>
        </div>
    </div>



    <hr class="featurette-divider">

    <div class="row featurette">
        <div class="col-md-7">
            <h2 style="color: red" class="featurette-heading">热门推荐<a href="/musicWeb/PlayListInfoServlet?method=allPlayLists" style="font-size:18px;color: black;float:right;">查看更多</a></h2>
                <ul id="playlist" class="listUl">
                    <c:if test="${not empty playPage.list}" >
                        <c:forEach items="${playPage.list}" var="list" varStatus="status">
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
        <div class="col-md-5">
            <img style="padding-top: 80px;" class="featurette-image img-responsive center-block" src="images/rr.gif" alt="Generic placeholder image">
            <p style="text-align: center;padding-top: 30px;font-size: 20px;" class="list-p">登录U享音乐,可以享受无限收藏的乐趣</p>
        </div>
    </div>

    <hr class="featurette-divider">

    <div class="row featurette">
        <div class="col-md-7 col-md-push-5">
            <h2 style="color: red" class="featurette-heading">歌曲榜单<a href="/musicWeb/ClassifyServlet?method=allSong" style="font-size:18px;color: black;float:right;">查看更多</a></h2>
            <div class="songBlist">
                <dl class="bl">
                    <dt class="bl-top">
                        <div class="bl-img">
                            <img src="images/hot.jpg" alt="">
                        </div>
                    </dt>
                    <dd>
                        <ol style="margin-top: 10px;font-size: 18px">
                            <c:if test="${not empty newPage}" >
                                <c:forEach items="${newPage}" var="newSong">
                                    <li>
                                        <a onclick="playMusic(this)" href="javascript:;">${newSong.songName}<span style="display: none" id="song-url">${newSong.url}</span></a>
                                    </li>
                                </c:forEach>
                            </c:if>
                        </ol>
                    </dd>
                </dl>
                <dl class="bl">
                    <dt class="bl-top">
                        <div class="bl-img">
                            <img src="images/surge.jpg" alt="">
                        </div>
                    </dt>
                    <dd>
                        <ol style="margin-top: 10px;font-size: 18px">
                            <c:if test="${not empty upPage}" >
                                <c:forEach items="${upPage}" var="up">
                                    <li>
                                        <a onclick="playMusic(this)" href="javascript:;">${up.songName}<span style="display: none" id="song-url">${up.url}</span></a>
                                    </li>
                                </c:forEach>
                            </c:if>
                        </ol>
                    </dd>
                </dl>
            </div>
        </div>
        <div class="col-md-5 col-md-pull-7">
            <img class="featurette-image img-responsive center-block" src="images/ss.jpg" alt="Generic placeholder image">
        </div>
    </div>

    <hr class="featurette-divider">

    <div class="row featurette">
        <div class="col-md-10">
            <p class="lead">登录享受更多服务</p>
        </div>
    </div>

    <hr class="featurette-divider">

    <!-- /END THE FEATURETTES -->


    <!-- FOOTER -->
    <footer>
        <p  class="pull-right back-top"><a href="#"><i class="fa fa-arrow-up"></i>TOP</a></p>
    </footer>
    <audio style="outline:none" id="music" src="" controls="controls" autoplay="" loop="loop" preload="auto">
    </audio>
    <script>
        function playMusic(id) {
            var src=$(id).children('span').eq(0).text();

            var play =  document.getElementById('music');
            $('#music').prop('src',src);
            play.play();
        }

    </script>
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
