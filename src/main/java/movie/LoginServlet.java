package movieProject;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


@WebServlet("/movieProject/loginServlet")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String userid = request.getParameter("userid");
		String userpwd = request.getParameter("userpwd");
		MovieMemberMgr mgr = new MovieMemberMgr();
		MovieMemberBeans bean =mgr.getMember(userid);
		boolean loginCheck = mgr.loginMember(userid, userpwd);
		
		
		
		
		if(loginCheck==false){
			response.sendRedirect("logError.jsp");
			System.out.println("로그인실패");
			
		}else{
			// 
			
			  HttpSession session = request.getSession();
			  session.setAttribute("userId", userid);
			  response.sendRedirect("/movieProject/myPage.jsp");
			  System.out.println("로그인 성공");
			  
		}
	}

}
