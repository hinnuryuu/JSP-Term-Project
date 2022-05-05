package com.project.myjsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet(name = "LoginServlet", value = "/LoginServlet")
public class LoginServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = "", password = "";
        int existCookie = 0;
        Cookie[] cookies = request.getCookies();
        for (Cookie cookie : cookies) {
            if (cookie.getName().equals("user")) {
                email = cookie.getValue();
                existCookie++;
            } else if (cookie.getName().equals("password")) {
                password = cookie.getValue();
                existCookie++;
            }
        }
        HttpSession session = request.getSession();
        response.setContentType("text/html;charset=utf-8");
        if (existCookie != 2) {
            email = request.getParameter("inputEmail");
            password = request.getParameter("inputPassword");
        }
        String givenCaptcha = "", realCaptcha = "";
        String remember = "";
        boolean rememberMe = false;
        if (existCookie != 2) {
            givenCaptcha = (request.getParameter("inputCaptcha")).toLowerCase();
            realCaptcha = ((String) request.getSession().getAttribute("captcha")).toLowerCase();
            remember = request.getParameter("remember")==null?"null":"remember-me";
            rememberMe= remember.equals("remember-me");
        }
        UserDB db = new UserDB();
        if (givenCaptcha.equals(realCaptcha) && existCookie < 2) {
            session.setAttribute("captchaRight", true);
            try {
                if (db.checkRightUser(email, password)&&rememberMe) {
                    Cookie user = new Cookie("user", email);
                    Cookie pwd = new Cookie("password", password);
                    user.setMaxAge(3600);
                    pwd.setMaxAge(3600);
                    response.addCookie(user);
                    response.addCookie(pwd);
                    session.setAttribute("upRight", true);
                    request.getRequestDispatcher("index.jsp").forward(request, response);
                } else if (db.checkRightUser(email, password)&&!rememberMe) {
                    session.setAttribute("upRight", true);
                    request.getRequestDispatcher("index.jsp").forward(request, response);
                } else {
                    session.setAttribute("upRight", false);
                    request.getRequestDispatcher("login.jsp").forward(request, response);
                }
            } catch (SQLException | ClassNotFoundException e) {
                throw new RuntimeException(e);
            }
        } else if (existCookie == 2) {
            try {
                if (db.checkRightUser(email, password)) {
                    session.setAttribute("upRight", true);
                    request.getRequestDispatcher("index.jsp").forward(request, response);
                } else {
                    session.setAttribute("upRight", false);
                    request.getRequestDispatcher("login.jsp").forward(request, response);
                }
            } catch (SQLException | ClassNotFoundException e) {
                throw new RuntimeException(e);
            }
        } else {
            session.setAttribute("captchaRight", false);
            session.setAttribute("upRight", false);
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}
