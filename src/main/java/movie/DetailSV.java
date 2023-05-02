package movie;

import java.io.IOException;


import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/movie")
public class DetailSV extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    
        	String movieId = request.getParameter("movieId");
        	
        	// Create an instance of DetailOut class
        	DetailOut detailOut = new DetailOut(movieId, request);
        	DetailOutBean detailOutBean = detailOut.getDetailOutBean(request);
        	
        	// Set the DetailOutBean object as an attribute of the request object
    		request.setAttribute("detailOutBean", detailOutBean);
    		
    		// Forward the request and response objects to the JSP
    		request.getRequestDispatcher("movieDetaildata.jsp").forward(request, response);
        }
    
}