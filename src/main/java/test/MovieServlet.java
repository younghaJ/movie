package test;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/movie/MovieServlet")
public class MovieServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	MovieMgr mgr = new MovieMgr();
    
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String keyword = request.getParameter("moviekeyword");
		ArrayList<MovieBean> arr = mgr.searchMovie(keyword);
		request.setAttribute("message", "검색이 완료되었습니다.");
		request.setAttribute("keyword", keyword);
		response.sendRedirect("test.jsp");
		
	}
}
