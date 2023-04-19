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
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js" integrity="sha384-oBqDVmMz9ATKxIep9tiCxS/Z9fNfEXiDAYTujMAeBAsjFuCZSmKbSSUnQlmh/jp3" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.min.js" integrity="sha384-cuYeSxntonz0PPNlHhBs68uyIAVpIIOZZ5JqeqvYYIcEL727kskC66kF92t6Xl2V" crossorigin="anonymous"></script>
</head>
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
	
	        <form class="col-12 col-lg-auto mb-3 mb-lg-0 me-lg-3" role="search">
	          <input type="search" class="form-control" placeholder="Search..." aria-label="Search">
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
	      <% if (count % 7 == 0) { %>
	        </tr><tr>
	      <% } %>
	    <% } %>
	    </tr>
	  </tbody>
	</table>
	
</body>
</html>
