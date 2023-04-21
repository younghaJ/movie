<%@page contentType="text/html; charset=UTF-8"%>
<%@page import="test.db" %>

<%
	db test = new db();
	for(int i=2; i<3; i++){
		out.println(test.load(i));
	}
	
%>