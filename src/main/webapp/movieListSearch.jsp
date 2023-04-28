<%@page import="javax.swing.text.Document"%>
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
	int pageSize = 30; // 한 페이지당 출력할 항목 개수
	int totalCount = 0; // 총 항목 개수
	String pageParam = request.getParameter("page"); // 요청한 페이지 번호
	
	if (pageParam != null && !pageParam.equals("")) {
	    pageNum = Integer.parseInt(pageParam);
	}
	
	ArrayList<MovieBean> movieList = new ArrayList<MovieBean>();
	int listnum = 1;
	while (true) {
	    ArrayList<MovieBean> tempList = mgr.getMovie(listnum);
	    if (tempList.size() == 0) {
	        break;
	    }
	    movieList.addAll(tempList);
	    listnum++;
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
    <style>
    	body {
		    background-color: #999999 !important;
		}
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
            max-width: 200px;
            max-height: 100%;
        }
    </style>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
</head>
<script type="text/javascript">
	function search() {
		document.searchFrm.submit();
		
	}
</script>
<body>
	<header class="p-3 mb-3 border-bottom">
    <div class="container">
      <div class="d-flex flex-wrap align-items-center justify-content-center justify-content-lg-start">
        <a href="/" class="d-flex align-items-center mb-2 mb-lg-0 text-dark text-decoration-none">
          <svg class="bi me-2" width="40" height="32" role="img" aria-label="Bootstrap"><use xlink:href="#bootstrap"></use></svg>
        </a>

        <ul class="nav col-12 col-lg-auto me-lg-auto mb-2 justify-content-center mb-md-0">
          <li><a href="#" class="nav-link px-2 link-secondary">Overview</a></li>
          <li><a href="#" class="nav-link px-2 link-dark">Inventory</a></li>
          <li><a href="#" class="nav-link px-2 link-dark">Customers</a></li>
          <li><a href="#" class="nav-link px-2 link-dark">Products</a></li>
        </ul>

		<form action="test/Movie" method="post" name="searchFrm">
	        <div class="col-12 col-lg-auto mb-3 mb-lg-0 me-lg-3 d-flex align-items-center">
			  <input type="search" class="form-control" placeholder="Search" aria-label="Search" name="moviekeyword">
			  <button type="button" class="btn btn-primary" id="searchBtn" style="width:80px; margin-left: 10px;" onclick="search()">검색</button>
			</div>
		</form>
		

        <div class="dropdown text-end">
          <a href="#" class="d-block link-dark text-decoration-none dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false">
            <img src="https://github.com/mdo.png" alt="mdo" width="32" height="32" class="rounded-circle">
          </a>
          <ul class="dropdown-menu text-small">
            <li><a class="dropdown-item" href="#">New project...</a></li>
            <li><a class="dropdown-item" href="#">Settings</a></li>
            <li><a class="dropdown-item" href="#">Profile</a></li>
            <li><hr class="dropdown-divider"></li>
            <li><a class="dropdown-item" href="#">Sign out</a></li>
          </ul>
        </div>
      </div>
    </div>
  </header>
  <div class="container">
    <table>
        <tbody>
            <% 
            int start = (pageNum - 1) * pageSize;
            int end = pageNum * pageSize;
            if (end > totalCount) {
                end = totalCount;
            }
            int count = 0;
            for (int i = start; i < end; i++) {
                if (count % 6 == 0) { %>
            <tr>
                <% } %>
                <td>
                    <img src="https://image.tmdb.org/t/p/w500<%=movieList.get(i).getPoster() %>">
                    <p><%=movieList.get(i).getTitle() %></p>
                </td>
                <% count++; %>
                <% if (count % 6 == 0) { %>
            </tr>
            <% } %>
            <% } %>
        </tbody>
    </table>
    </div>
    <div class="container">
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
	        </li>
	        <% } %>
	    </ul>
	    <% } %>
	</div>
	<script type="text/javascript">document.getElementById("container").style.display = "none";</script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
