import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "Servlet")
public class ButtonStatusServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        CurrentGson gson = new CurrentGson();
        String string = "";
        try {
            string = gson.doGet("http://192.168.43.19:8001/button_status");
        } catch (Exception e) {
            e.printStackTrace();
        }
        response.setContentType("text/html; charset=utf-8");
        response.getWriter().write(string);


    }
}
