<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="test.db" %>
<%@page import="test.MovieBean"%>
<%@page import="java.util.ArrayList"%>
<jsp:useBean id="mgr" class="test.MovieMgr"/>
<%
    db test = new db();
    ArrayList<MovieBean> movieList = new ArrayList<MovieBean>();

    for (int i = 1; i <= 100; i++) {
        ArrayList<MovieBean> tempList = mgr.getMovie(i);
        movieList.addAll(tempList);
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>영화 목록</title>
    <style>
        table {
            border-collapse: collapse;
            width: 100%;
        }
        th, td {
            padding: 8px;
            text-align: center;
            border-bottom: 1px solid #ddd;
        }
        th {
            background-color: #f2f2f2;
            color: #333;
        }
        img {
            max-width: 100%;
            max-height: 100%;
        }
    </style>
</head>
<body>
    <table>
	  <thead>
	    <tr>
	      <th></th>
	    </tr>
	  </thead>
	  <tbody>
	    <% int count = 0; %>
	    <tr>
	    <% for (MovieBean bean : movieList) { %>
	      <td>
	        <img src="https://image.tmdb.org/t/p/w500<%=bean.getPoster() %>">
	        <p><%=bean.getTitle() %></p>
	      </td>
	      <% count++; %>
	      <% if (count % 5 == 0) { %>
	        </tr><tr>
	      <% } %>
	    <% } %>
	    </tr>
	  </tbody>
	</table>
</body>
</html>
