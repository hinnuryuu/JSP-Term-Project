package com.project.myjsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet(name = "AuthorityServlet", value = "/AuthorityServlet")
public class AuthorityServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        UserDB db=new UserDB();
        User user = db.searchByEmail((String) session.getAttribute("loginEmail"));
        if(user.getAdmin()==0){
            try {
                db.switchAuthority(user,1);
            } catch (SQLException | ClassNotFoundException e) {
                throw new RuntimeException(e);
            }
        }else{
            try {
                db.switchAuthority(user,0);
            } catch (SQLException | ClassNotFoundException e) {
                throw new RuntimeException(e);
            }
        }
        response.getWriter().print("<script>alert('权限组更改成功!');</script>");
        response.sendRedirect("profile.jsp");
    }
}
