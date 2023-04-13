<%@page contentType="text/html; charset=UTF-8"%>
<%@page import="test.Save" %>

<%
	Save saver = new Save();
	saver.insertMovie();
%>