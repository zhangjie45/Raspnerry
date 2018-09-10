
import java.io.IOException;

public class currentServlet extends javax.servlet.http.HttpServlet {
    protected void doPost(javax.servlet.http.HttpServletRequest request, javax.servlet.http.HttpServletResponse response) throws javax.servlet.ServletException, IOException {
        CurrentGson gson = new CurrentGson();
        String str = "";
        try {
            str = gson.doGet("http://192.168.43.19:8001/current_table");
        } catch (Exception e) {
            e.printStackTrace();
        }
        response.setContentType("text/html; charset=utf-8");
        response.getWriter().write(str);
    }

    protected void doGet(javax.servlet.http.HttpServletRequest request, javax.servlet.http.HttpServletResponse response) throws javax.servlet.ServletException, IOException {

    }
}
