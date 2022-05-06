<%@ page import="com.project.myjsp.User" %>
<%@ page import="com.project.myjsp.UserDB" %><%--个人信息更改页面--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<html lang="zh-CN">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>更改页面</title>

    <!-- Bootstrap core CSS -->
    <link href="css/bootstrap.min.css" rel="stylesheet">

    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <link href="css/ie10-viewport-bug-workaround.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="css/change.css" rel="stylesheet">

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
    request.setCharacterEncoding("utf-8");
    if (session.getAttribute("upRight") == null || !(boolean) session.getAttribute("upRight")) {
%>
<script>
    window.alert("您还未登录,请先登录.");
    window.location.href = 'login.jsp';
</script>
<%
} else {
    if (session.getAttribute("changeRight") != null && !(boolean) session.getAttribute("changeRight")) {
        session.setAttribute("changeRight", null);
%>
<script>
    window.alert("账号信息更改时出错,我们无法确认该更改请求来源于您本人.")
</script>
<%
} else {
    UserDB db = new UserDB();
    User user = db.searchByEmail((String) session.getAttribute("loginEmail"));
%>
<body style="background-image: url('bg-change.png');background-repeat: no-repeat;background-size: cover">

<div class="container">
    <form class="form-change" method="post" action="UpdateServlet">
        <h2 class="form-change-heading"><font color="#f0ffff">用户更改</font></h2>
        <div class="form-group">
            <label for="inputUsername" class="sr-only">用户名</label>
            <input type="text" id="inputUsername" name="username" class="form-control" placeholder="更改您的用户名"
                   value="<%=user.getId()%>" required>
            <label for="inputEmail" class="sr-only">电子邮箱</label>
            <input type="email" id="inputEmail" name="email" class="form-control" placeholder="更改您的电子邮箱"
                   value="<%=user.getEmail()%>" required>
            <label for="inputPassword" class="sr-only">密码</label>
            <input type="password" id="inputPassword" name="password" class="form-control" placeholder="更改您的密码">
            <label for="inputAge"><font color="#f0ffff">更改您的年龄</font></label><input type="number" id="inputAge"
                                                                                    name="age" class="form-control"
                                                                                    placeholder="更改您的年龄"
                                                                                    value="<%=user.getAge()%>" required>
            <%
                String gender = user.getGender();
                if (gender.equals("male")) {
            %>
            <label for="inputGender"><font color="#f0ffff">更改您的性别</font></label>
            <select class="form-control" id="inputGender" name="gender">
                <option value="male" selected>男</option>
                <option value="female">女</option>
                <option value="none">保密</option>
            </select>
            <%
            } else if (gender.equals("female")) {
            %>
            <label for="inputGender"><font color="#f0ffff">更改您的性别</font></label>
            <select class="form-control" id="inputGender" name="gender">
                <option value="male">男</option>
                <option value="female" selected>女</option>
                <option value="none">保密</option>
            </select>
            <%
            } else {
            %>
            <label for="inputGender"><font color="#f0ffff">更改您的性别</font></label>
            <select class="form-control" id="inputGender" name="gender">
                <option value="male">男</option>
                <option value="female">女</option>
                <option value="none" selected>保密</option>
            </select>
            <%
                }
            %>
        </div>

        <span class="form-group"><label for="confirmPassword"><font color="#f0ffff">当前密码:</font></label><input
                type="password" id="confirmPassword" name="confirm" class="form-control" placeholder="填写当前账户密码"
                required></span>
        <button class="btn btn-lg btn-primary btn-block" type="submit">提交更改</button>
    </form>
</div> <!-- /container -->


<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
<script src="js/ie10-viewport-bug-workaround.js"></script>
</body>
<%
        }
    }
%>
</html>
