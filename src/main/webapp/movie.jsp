<%@page contentType="text/html; charset=UTF-8"%>
<%@page import="test.db" %>
<%@page import="test.Save" %>

<%
	db test = new db();
	for(int i=1; i<3; i++){
		out.println(test.load(i));
	}
	
%>