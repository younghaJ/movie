<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="test.db" %>
<%@page import="test.MovieBean"%>
<%@page import="java.util.Vector"%>
<jsp:useBean id = "mgr" class = "test.MovieMgr"/>
<%
	db test = new db();
	MovieBean bean = new MovieBean();
	Vector<MovieBean> vlist = mgr.getMovie(1);
	bean = vlist.get(0);
	String title = bean.getTitle();
	String image = bean.getPoster();
	String content = bean.getContent();
	
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
				<th></th>
				<th></th>
				<th></th>
				<th></th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td>
					<%
						Vector<MovieBean> vlist1 = mgr.getMovie(1);
						MovieBean bean1 = vlist1.get(0);
						String image1 = bean1.getPoster();
					%>
					<img src="https://image.tmdb.org/t/p/w500<%=image1 %>">
				</td>
				<td>
					<%
						Vector<MovieBean> vlist2 = mgr.getMovie(2);
						MovieBean bean2 = vlist2.get(0);
						String image2 = bean2.getPoster();
						String title2 = bean2.getTitle();
					%>
					<img src="https://image.tmdb.org/t/p/w500<%=image2 %>">
				</td>
				<td>
					<%
						Vector<MovieBean> vlist3 = mgr.getMovie(3);
						MovieBean bean3 = vlist3.get(0);
						String image3 = bean3.getPoster();
						String title3 = bean3.getTitle();
					%>
					<img src="https://image.tmdb.org/t/p/w500<%=image3 %>">
				</td>
				<td><img src="https://image.tmdb.org/t/p/w500<%=image %>"></td>
				<td><img src="https://image.tmdb.org/t/p/w500<%=image %>"></td>
			</tr>
			<tr>
				<td><%=title %></td>
				<td><%=title2 %></td>
				<td><%=title3 %></td>
				<td><%=title %></td>
				<td><%=title %></td>
			</tr>
			<!-- 추가 상품 정보 -->
		</tbody>
	</table>
</body>
</html>
