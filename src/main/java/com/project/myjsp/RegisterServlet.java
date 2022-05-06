package com.project.myjsp;



import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.util.Calendar;

@WebServlet(name = "RegisterServlet", value = "/RegisterServlet")
public class RegisterServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        HttpSession session = request.getSession();
        Calendar cal = Calendar.getInstance();
        String email = request.getParameter("inputEmail");
        String username = request.getParameter("inputUsername");
        String password = request.getParameter("inputPassword");
        String birthday = request.getParameter("inputBirthday");
        String gender = request.getParameter("inputGender");
        int birth_year = Integer.parseInt(birthday.substring(0,4));
        int now_year = cal.get(Calendar.YEAR);
        int age = now_year-birth_year;
        UserDB db = new UserDB();
        try {
            if(db.existUser(email)){
                session.setAttribute("existUser",true);
                response.sendRedirect("register.jsp");
            }else {
                session.setAttribute("existUser",false);
                User user = new User(username,password,gender,age,email,0);
                db.insert(user);
                response.sendRedirect("register.jsp");
            }
        } catch (SQLException | ClassNotFoundException e) {
            throw new RuntimeException(e);
        }
    }
}
