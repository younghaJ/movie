<%@page contentType="text/html; charset=UTF-8"%>
<%@page import="movie.db" %>

<%
	db test = new db();
	//for(int year=2016; year<=2023; year++){
		for(int i=1; i<=3; i++){
			out.println(test.load(i, 2017));
		}
	//}
%>