<%--主页面--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<html lang="zh-CN">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>主页面</title>

    <!-- Bootstrap core CSS -->
    <link href="css/bootstrap.min.css" rel="stylesheet">

    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <link href="css/ie10-viewport-bug-workaround.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="css/cover.css" rel="stylesheet">

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

<body>

<div class="site-wrapper">
    <div class="site-wrapper-inner">
        <div class="cover-container">
            <div class="masthead clearfix">
                <div class="inner">
                    <h3 class="masthead-brand">首页</h3>
                    <nav>
                        <ul class="nav masthead-nav">
                            <li class="active"><a href="#">主页</a></li>
                            <%
                                if (session.getAttribute("upRight") == null || !(boolean) session.getAttribute("upRight")) {
                            %>
                            <li><a href="login.jsp">登录</a></li>
                            <li><a href="register.jsp">注册</a></li>
                            <%
                            } else {
                            %>
                            <li><a href="profile.jsp">个人信息</a></li>
                            <li><a href="LogoutServlet">退出登录</a></li>
                            <%
                                }
                            %>
                        </ul>
                    </nav>
                </div>
            </div>

            <div class="inner cover">
                <h1 class="cover-heading">这是一份由JSP，Servlet，JavaBean以及MySQL实现的一个网页应用。</h1>
                <p class="lead">这个网页前端基于Bootstrap 3实现，后端实现的功能有登入，注册，个人信息操作。其中登录支持cookie存取，依据邮箱注册，个人信息操作可以销号、登出和更新信息。</p>
                <p class="lead">
                    <a href="#" class="btn btn-lg btn-default">看看我还能干什么？</a>
                </p>
            </div>

            <div class="mastfoot">
                <div class="inner">
                    <p>由<a href="https://getbootstrap.com/">Bootstrap 3</a>实现页面布局 , 将此作业已开源于 <a
                            href="https://github.com/hinnuryuu">Github</a>.</p>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Bootstrap core JavaScript
================================================== -->
<!-- Placed at the end of the document so the pages load faster -->
<script src="js/jquery.min.js" integrity="sha384-nvAa0+6Qg9clwYCGGPpDQLVpLNn0fRaROjHqs13t4Ggj3Ez50XnGQqc/r8MhnRDZ"
        crossorigin="anonymous"></script>
<script>window.jQuery || document.write('<script src="js/vendor/jquery.min.js"><\/script>')</script>
<script src="js/bootstrap.min.js"></script>
<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
<script src="js/ie10-viewport-bug-workaround.js"></script>
</body>
</html>
