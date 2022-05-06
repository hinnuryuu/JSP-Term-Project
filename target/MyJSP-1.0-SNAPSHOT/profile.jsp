<%--个人信息显示页面--%>
<%@ page import="com.project.myjsp.UserDB" %>
<%@ page import="com.project.myjsp.User" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<html lang="zh-CN">
<head>
    <meta charset="utf-8">
    <title>个人信息页面</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">

    <!-- Bootstrap CSS File -->
    <link href="css/bootstrap.min.css" rel="stylesheet">

    <!-- Libraries CSS Files -->
    <link href="css/font-awesome.min.css" rel="stylesheet">

    <!-- Main Stylesheet File -->
    <link href="css/myself.css" rel="stylesheet">
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
    UserDB db = new UserDB();
    User user = db.searchByEmail((String) session.getAttribute("loginEmail"));
    if (session.getAttribute("cancelRight") != null && !(boolean) session.getAttribute("cancelRight")) {
        session.setAttribute("cancelRight",null);
%>
<script>
    window.alert("账号注销时出错,我们无法确认该注销请求来源于您本人.")
</script>
<%
    } else{
%>
<body>
<div class="container">
    <div class="col-lg-6 col-lg-offset-3">

        <!-- ===== vCard Navigation ===== -->
        <div class="row w">
            <div class="col-md-4">
                <ul class="nav nav-tabs nav-stacked" id="myTab">
                    <li class="active"><a href="#about">个人资料</a></li>
                    <li><a href="#change">资料更改</a></li>
                    <li><a href="#cancel">账号注销</a></li>
                </ul>
            </div>
            <!-- col-md-4 -->

            <!-- ===== vCard Content ===== -->
            <div class="col-md-8">
                <div class="tab-content">

                    <!-- ===== First Tab ===== -->
                    <div class="tab-pane active" id="about">
                        <h3>个人资料</h3>
                        <h5>登录账户：<%=user.getEmail()%>
                        </h5>
                        <hr>
                        <p>用户名:<%=user.getId()%>
                        </p>
                        <p>电子邮箱:<%=user.getEmail()%>
                        </p>
                        <p>年龄:<%=user.getAge()%>
                        </p>
                        <%
                            if (user.getGender().equals("none")) {
                        %>
                        <p>性别:保密</p>
                        <%
                        } else {
                            if (user.getGender().equals("male")) {
                        %>
                        <p>性别:男性</p>
                        <%
                        } else {
                        %>
                        <p>性别:女性</p>
                        <%
                                }
                            }
                        %>
                        <%
                            if (user.getAdmin() == 0) {
                        %>
                        <p>权限组:您目前不是超级管理员</p>
                        <%
                        } else {
                        %>
                        <p>权限组:您目前是超级管理员</p>
                        <%
                            }
                        %>
                    </div>
                    <!-- tab about -->


                    <!-- ===== Second Tab ===== -->
                    <div class="tab-pane" id="change">
                        <div class="row">
                            <div class="col-xs-6 centered">
                                <img class="img-responsive" src="img/p01.png" alt="">
                                <a href="change.jsp"><h6> 更改个人资料</h6></a>
                            </div>
                            <!-- col-xs-6 -->
                            <div class="col-xs-6 centered">
                                <img class="img-responsive" src="img/p02.png" alt="">
                                <a href="AuthorityServlet"><h6> 权限组变更</h6></a>
                            </div>
                            <!-- col-xs-6 -->
                        </div>
                        <!-- row -->
                    </div>
                    <!-- /Tab change -->

                    <!-- ===== Third Tab ===== -->
                    <div class="tab-pane" id="cancel">
                        <h4>账号注销</h4>
                        <hr>
                        <h5>注意:账号一旦注销,它将可能会消失很久(真的很久),你确定注销吗?</h5>
                        <p>如果确定注销请在以下输入框中填入密码,我们以确保您本人的操作.</p>
                        <form class="form-group" action="CancelServlet" method="post">
                            <span class="form-inline">
                                <label for="password">请输入密码以继续注销:</label>
                                <input id="password" name="password" class="form-control" type="password">
                            </span>
                            <button class="btn btn-lg btn-block btn-danger" type="submit">提交注销请求</button>
                        </form>
                    </div>
                    <!-- Tab cancel -->
                </div>
                <!-- Tab Content -->
            </div>
            <!-- col-md-8 -->
        </div>
        <!-- row w -->
    </div>
    <!-- col-lg-6 -->
</div>
<!-- /.container -->


<!-- JavaScript Libraries -->
<script src="js/jquery.min.js"></script>
<script src="js/bootstrap.min.js"></script>

<!-- Template Main Javascript File -->
<script src="js/myself.js"></script>
</body>
<%
        }
    }
%>
</html>
