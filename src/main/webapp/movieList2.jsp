<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="test.db" %>
<%@page import="test.MovieBean"%>
<%@page import="java.util.ArrayList"%>
<jsp:useBean id="mgr" class="test.MovieMgr"/>
<%
    db test = new db();
    int pageNum = 1; // 현재 페이지 번호
    int totalPageNum = 1; // 총 페이지 개수
    int pageSize = 6; // 한 페이지당 출력할 항목 개수
    int totalCount = 0; // 총 항목 개수
    String pageParam = request.getParameter("page"); // 요청한 페이지 번호
    if (pageParam != null && !pageParam.equals("")) {
        pageNum = Integer.parseInt(pageParam);
    }

    ArrayList<MovieBean> movieList = new ArrayList<MovieBean>();
    for (int i = 1; i <= 100; i++) {
        ArrayList<MovieBean> tempList = mgr.getMovie(i);
        movieList.addAll(tempList);
    }

    totalCount = movieList.size(); // 총 항목 개수
    if (totalCount % pageSize == 0) {
        totalPageNum = totalCount / pageSize;
    } else {
        totalPageNum = (totalCount / pageSize) + 1;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>영화 목록</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
</head>
<body>
  <div class="container">
    <table>
      <tbody>
        <% 
            int start = (pageNum - 1) * pageSize;
            int end = pageNum * pageSize;
            if (end > totalCount) {
                end = totalCount;
            }
            for (int i = start; i < end; i++) {
                MovieBean bean = movieList.get(i);
        %>
            <tr>
                <td>
                    <img src="https://image.tmdb.org/t/p/w500<%=bean.getPoster() %>">
                    <p><%=bean.getTitle() %></p>
                </td>
            </tr>
        <% } %>
      </tbody>
    </table>
    <% if (totalPageNum > 1) { %>
        <ul class="pagination">
            <% if (pageNum > 1) { %>
                <li class="page-item">
                    <a class="page-link" href="?page=<%=pageNum-1 %>">&laquo;</a>
                </li>
            <% } %>
            <% for (int i = 1; i <= totalPageNum; i++) { %>
                <li class="page-item <%= (i == pageNum) ? "active" : "" %>">
                    <a class="page-link" href="?page=<%=i %>"><%=i %></a>
                </li>
            <% } %>
            <% if (pageNum < totalPageNum) { %>
                <li class="page-item">
                    <a class="page-link" href="?page=<%=pageNum+1 %>">&raquo;</a>
                    </ul>
    <% } }%>
  </div>
</body>
</html>
