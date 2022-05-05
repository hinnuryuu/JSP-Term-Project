package com.project.myjsp;

import javax.imageio.ImageIO;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.util.Locale;
import java.util.Random;

@WebServlet(name = "CaptchaServlet", value = "/CaptchaServlet")
public class CaptchaServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        Random r = new Random();
        BufferedImage pen = new BufferedImage(60, 30, BufferedImage.TYPE_INT_RGB);
        Graphics g = pen.getGraphics();
        Color c = new Color(255, 204, 221,255);
        g.setColor(c);
        g.fillRect(0, 0, 60, 30);

        char[] ch = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789".toCharArray();
        int len = ch.length;
        int index;
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < 4; i++) {
            index = r.nextInt(len);
            g.setColor(new Color(r.nextInt(255), r.nextInt(255), r.nextInt(255)));
            g.drawString(ch[index] + "", (i * 15) + 3, 18 + i * (i % 2 == 0 ? 1 : -1));
            sb.append(ch[index]);
        }
        request.getSession().setAttribute("captcha", sb.toString());
        ImageIO.write(pen, "JPG", response.getOutputStream());
    }
}
