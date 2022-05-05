<%--注册页面--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<html lang="zh-CN">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>注册页面</title>

    <!-- Bootstrap core CSS -->
    <link href="css/bootstrap.min.css" rel="stylesheet">

    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <link href="css/ie10-viewport-bug-workaround.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="css/signin.css" rel="stylesheet">

    <!-- Just for debugging purposes. Don't actually copy these 2 lines! -->
    <!--[if lt IE 9]>
    <script src="js/ie8-responsive-file-warning.js"></script><![endif]-->
    <script src="js/ie-emulation-modes-warning.js"></script>

    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
    <script src="js/html5shiv.min.js"></script>
    <script src="js/respond.min.js"></script>
    <![endif]-->
</head>
<%
    if (session.getAttribute("upRight") != null) {
        if ((boolean) session.getAttribute("upRight")) {
            response.sendRedirect("index.jsp");
        }
    }
%>
<body style="background-image: url('bg-register.png');background-repeat: no-repeat;background-size: cover">

<div class="container">

    <form class="form-signin" method="post" action="RegisterServlet">
        <h2 class="form-signin-heading"><font color="#f0ffff">用户注册</font></h2>
        <div class="form-group">
            <label for="inputUsername" class="sr-only">用户名</label>
            <input type="text" id="inputUsername" name="inputUsername" class="form-control" placeholder="键入您的用户名"
                   required autofocus>
        </div>
        <div class="form-group">
            <label for="inputEmail" class="sr-only">电子邮箱</label>
            <input type="email" id="inputEmail" name="inputEmail" class="form-control" placeholder="键入您的电子邮箱" required>
            <label for="inputPassword" class="sr-only">密码</label>
            <input type="password" id="inputPassword" name="inputPassword" class="form-control" placeholder="键入您的密码"
                   required>
        </div>
        <div class="form-group">
            <label for="inputBirthday"><font color="#f0ffff">填写您的生日</font></label>
            <input type="date" id="inputBirthday" name="inputBirthday" class="form-control" placeholder="键入您的生日"
                   required>
            <label for="inputGender"><font color="#f0ffff">填写您的性别</font></label>
            <select class="form-control" id="inputGender" name="inputGender" required>
                <option value="male">男</option>
                <option value="female">女</option>
                <option value="none">保密</option>
            </select>
        </div>
        <button class="btn btn-lg btn-primary btn-block" type="submit">注册</button>
    </form>
    <%
        if (session.getAttribute("existUser") != null) {
            boolean existUser = (boolean) session.getAttribute("existUser");
            if (existUser) {
    %>
    <script>
        window.alert("该邮箱已经被注册,现为您跳转至登录页面...");
        window.location.href = 'login.jsp';
    </script>
    <%
    } else {
    %>
    <script>
        window.alert("注册成功,现为您跳转至登录页面...");
        window.location.href = 'login.jsp';
    </script>
    <%
            }
        }
    %>
</div> <!-- /container -->


<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
<script src="js/ie10-viewport-bug-workaround.js"></script>
</body>
</html>
