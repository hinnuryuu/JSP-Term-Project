<%--登录页面--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<html lang="zh-CN">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>登录页面</title>

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
    <script type="text/javascript">
        function reloadCode() {
            const time = new Date().getTime();
            document.getElementById("viewCaptcha").src = "CaptchaServlet?d=" + time;
        }
    </script>
</head>
<%
    request.setCharacterEncoding("utf-8");
    int existCookie = 0;
    if (request.getCookies() != null) {
        Cookie[] cookies = request.getCookies();
        for (Cookie cookie : cookies) {
            if (cookie.getName().equals("user")) {
                existCookie++;
            } else if (cookie.getName().equals("password")) {
                existCookie++;
            }
        }
    }
    if (existCookie == 2) {
%>
<script>window.location.href = 'LoginServlet';</script>
<%
} else {
    if (session.getAttribute("upRight")!=null && (boolean) session.getAttribute("upRight")) {
        response.sendRedirect("index.jsp");
    } else {
%>
<body style="background-image: url('bg-login.jpg');background-repeat: no-repeat;background-size: cover">

<div class="container">

    <form class="form-signin" method="post" action="LoginServlet">
        <h2 class="form-signin-heading"><font color="#f0ffff">用户登录</font></h2>
        <div class="form-group">
            <label for="inputEmail" class="sr-only">电子邮箱</label>
            <input type="email" id="inputEmail" name="inputEmail" class="form-control" placeholder="键入您的电子邮箱" required
                   autofocus>
            <label for="inputPassword" class="sr-only">密码</label>
            <input type="password" id="inputPassword" name="inputPassword" class="form-control" placeholder="键入您的密码"
                   required>
        </div>
        <div class="form-group" align="center">
            <span class="form-inline">
                <label for="inputCaptcha" class="sr-only">验证码</label>
                <input type="text" id="inputCaptcha" name="inputCaptcha" class="form-control" placeholder="键入验证码"
                       style="text-align: center;height: 30px;width: 170px;">
                <a href="javascript: reloadCode()"><img alt="captcha" id="viewCaptcha" src="CaptchaServlet"
                                                        class="img-rounded" style="width: auto;height: auto"/></a>
            </span>
        </div>
        <div class="checkbox">
            <label>
                <input type="checkbox" value="remember-me" name="remember"> 记住我
            </label>
        </div>
        <button class="btn btn-lg btn-primary btn-block" type="submit">登录</button>
    </form>
    <%
        if (session.getAttribute("captchaRight") != null && session.getAttribute("upRight") != null) {
            if (!(boolean) session.getAttribute("captchaRight")) {
    %>
    <script>
        window.alert("验证码错误！");
    </script>
    <%
        session.setAttribute("captchaRight", null);
    } else if (!(boolean) session.getAttribute("upRight")) {
    %>
    <script>
        window.alert("电子邮箱或密码错误！");
    </script>
    <%
                session.setAttribute("captchaRight", null);
            }
        }
    %>
</div> <!-- /container -->
<%
        }
    }
%>

<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
<script src="js/ie10-viewport-bug-workaround.js"></script>
</body>
</html>