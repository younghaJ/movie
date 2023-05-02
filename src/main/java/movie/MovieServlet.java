package movie;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/test/Movie")
public class MovieServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	MovieMgr mgr = new MovieMgr();
    
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("EUC-KR");
		String keyword = request.getParameter("moviekeyword");
		ArrayList<MovieBean> arr = mgr.searchMovie(keyword);
		
		//request.setAttribute("keyword", keyword);
		//response.sendRedirect("test.jsp");
		response.setContentType("text/html; charset=EUC-KR");
		PrintWriter out = response.getWriter();
		System.out.println(arr);
		out.print(keyword);
		System.out.println(keyword);
	}
}
