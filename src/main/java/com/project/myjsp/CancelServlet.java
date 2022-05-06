package com.project.myjsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet(name = "CancelServlet", value = "/CancelServlet")
public class CancelServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        HttpSession session = request.getSession();
        UserDB db = new UserDB();
        String password = request.getParameter("password");
        User user = db.searchByEmailPassword((String) session.getAttribute("loginEmail"),password);
        if(user==null){
            session.setAttribute("cancelRight",false);
            response.sendRedirect("profile.jsp");
        }else{
            try {
                db.delete(user);
                response.sendRedirect("LogoutServlet");
            } catch (SQLException | ClassNotFoundException e) {
                throw new RuntimeException(e);
            }
        }
    }
}
