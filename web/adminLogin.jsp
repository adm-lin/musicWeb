<%--
  Created by IntelliJ IDEA.
  User: Hasee
  Date: 2020/12/26
  Time: 20:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link rel="stylesheet" type="text/css" href="css/adminLogin.css" />
    <title>后台登录</title>
    <script>
        function validate() {
            var account =document.getElementById("adAccount").value;
            var password =document.getElementById("adPassword").value;

            //验证邮箱合法性
            if(account==''){
                alert("account不能为空");
                return false;
            }
            if(password==''){
                alert("password不能为空");
                return false;
            }
            return true;
        }
    </script>
</head>
<body>

<div class="back">
    <div class="back1">
        <div class="lo-form">
            <div class="lo">
                <form id="form1" action="/musicWeb/AdminLoginServlet?method=login" method="post" name="login" onsubmit="return validate()">
                    <div class="setcenter">
                        <h1>U享音乐后台登录</h1>
                        <div class="form-set">
                            <label>账户：</label>
                            <input name="adAccount" id="adAccount" type="text" placeholder="请输入账户"/>
                        </div>
                        <div class="form-set">
                            <label>密码：</label>
                            <input name="adPassword" id="adPassword" type="password" placeholder="请输入密码"/>
                        </div>
                        <div class="form-set2">
                            <input class="loBtn" type="submit" value="登录" />
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
</body>
</html>
