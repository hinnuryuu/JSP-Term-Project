package com.project.myjsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet(name = "UpdateServlet", value = "/UpdateServlet")
public class UpdateServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        HttpSession session = request.getSession();
        UserDB db = new UserDB();
        String confirm = request.getParameter("confirm");
        User user = db.searchByEmailPassword((String) session.getAttribute("loginEmail"), confirm);
        if (user == null) {
            session.setAttribute("changeRight", false);
            response.sendRedirect("change.jsp");
        } else {
            try {
                String username, password, gender, email;
                int age;

                if (!request.getParameter("username").equals(user.getId())) {
                    username = request.getParameter("username");
                } else username = user.getId();

                if (!request.getParameter("password").equals("") && !request.getParameter("password").equals(user.getPwd())) {
                    password = request.getParameter("password");
                } else password = user.getPwd();

                if (!request.getParameter("gender").equals(user.getGender())) {
                    gender = request.getParameter("gender");
                } else gender = user.getGender();

                if (!request.getParameter("email").equals(user.getEmail())) {
                    email = request.getParameter("email");
                } else email = user.getEmail();

                if (Integer.parseInt(request.getParameter("age")) != user.getAge()) {
                    age = Integer.parseInt(request.getParameter("age"));
                } else age = user.getAge();

                if (request.getCookies() != null) {  //防止cookie失效,更改信息后会更新cookie值
                    Cookie[] cookies = request.getCookies();
                    for (Cookie cookie : cookies) {
                        if (cookie.getName().equals("user")) {
                            cookie.setValue(email);
                            cookie.setMaxAge(3600);
                            response.addCookie(cookie);
                        } else if (cookie.getName().equals("password")) {
                            cookie.setValue(password);
                            cookie.setMaxAge(3600);
                            response.addCookie(cookie);
                        }
                    }
                }
                session.setAttribute("loginEmail", email);//登录凭证也不能不改,否则出大问题
                db.update(user, username, password, gender, age, email);
                response.sendRedirect("profile.jsp");
            } catch (SQLException | ClassNotFoundException e) {
                throw new RuntimeException(e);
            }
        }
    }
}
