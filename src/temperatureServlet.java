import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "temperatureServlet")
public class temperatureServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        CurrentGson gson = new CurrentGson();
        String string = "";
        try {
            string = gson.doGet("http://192.168.43.19:8001/temp_table");
        } catch (Exception e) {
            e.printStackTrace();
        }
        response.setContentType("text/html; charset=utf-8");
        response.getWriter().write(string);
    }


}
