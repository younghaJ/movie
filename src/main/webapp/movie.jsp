<%@page contentType="text/html; charset=UTF-8"%>
<%@page import="test.db" %>

<%
	db test = new db();
	for(int i=6; i<15; i++){
		out.println(test.load(i));
	}
	
%>