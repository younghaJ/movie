<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="test.db" %>
<%@page import="test.MovieBean"%>
<%@page import="java.util.ArrayList"%>
<jsp:useBean id="mgr" class="test.MovieMgr"/>
<%
int currentPage = 1;
int totalCount = 35;
int pageSize = 7;
int totalPage = (totalCount + pageSize - 1) / pageSize;
int startPage = ((currentPage - 1) / pageSize) * pageSize + 1;
int endPage = startPage + pageSize - 1;
if (endPage > totalPage) endPage = totalPage;

ArrayList<MovieBean> movieList = mgr.getMoviel(currentPage, pageSize); // DB에서 조회된 결과를 받아옵니다.
%>
<% int count = 0; %>
<tr>
	    <% for (MovieBean bean : movieList) { %>
	      <td>
	        <img src="https://image.tmdb.org/t/p/w500<%=bean.getPoster() %>">
	        <p><%=bean.getTitle() %></p>
	      </td>
	      <% count++; %>
	      <% if (count % 7 == 0) { %>
	        </tr><tr>
	      <% } %>
	    <% } %>
	    </tr>
<%
// 페이지 링크를 출력합니다.
if (startPage > pageSize) {
    out.println("<a href='?currentPage=" + (startPage - 1) + "'>이전</a>");
}
for (int i = startPage; i <= endPage; i++) {
    if (i == currentPage) {
        out.println("<b>" + i + "</b>");
    } else {
        out.println("<a href='?currentPage=" + i + "'>" + i + "</a>");
    }
}
if (endPage < totalPage) {
    out.println("<a href='?currentPage=" + (endPage + 1) + "'>다음</a>");
}
%>