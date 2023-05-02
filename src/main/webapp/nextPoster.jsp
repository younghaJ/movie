<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="movie.db" %>
<%@page import="movie.MovieBean"%>
<%@page import="java.util.Vector"%>
<jsp:useBean id = "r m" class = "w movie.MovieM"/>
<%
	db test = new db();
	MovieBean bean = new MovieBean();
	ArrayList<MovieBean> vlist = mgr.getMovie(1);
	bean = vlist.get(0);
	String title = bean.getTitle();
	String image = bean.getPoster();
	String content = bean.getContent();
	out.println(title);
	out.println(image);
	out.println(content);
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Movie Site</title>

</head>
<link href="style.css" rel="stylesheet" type="text/css">
<body>
	<nav>
		<div>
			<img
				src="https://img1.daumcdn.net/thumb/R658x0.q70/?fname=https://t1.daumcdn.net/news/202208/26/NEWS1/20220826121517452duxo.jpg"
				alt="Logo" style="width: 100px; height: 25px;"> <span>(12)</span>
		</div>
		<div>
			<form>
				<input type="text" placeholder="Search..">
			</form>
			<div>
				<a href="#home">Home</a> <a href="#news">News</a> <a href="#contact">Contact</a>
				<a href="#about">About</a>
			</div>
		</div>
	</nav>
	<div class="card">
		<img
			src="https://image.tmdb.org/t/p/w500<%=image %>"
			alt="스즈메의 문단속"  style="width: 50%">
		<div class="text-container">
			<div class="title">
				<h4>
					<b><%=title %></b>
				</h4>
			</div>
			<div class="container">
				<table>
					<tr>
						<td>개봉</td>
						<td>2023.03.08</td>
					</tr>
					<tr>
						<td>장르</td>
						<td>애니메이션/어드벤처/판타지</td>
					</tr>
					<tr>
						<td>국가</td>
						<td>일본</td>
					</tr>
					<tr>
						<td>등급</td>
						<td>12세이상관람가</td>
					</tr>
					<tr>
						<td>런타임</td>
						<td>122분</td>
					</tr>
					<tr>
						<td>감독</td>
						<td>신카이 마코토</td>
					</tr>
					
				</table>
			</div>
			<hr>
			<div>
				<tr>
					<td>줄거리 : </td>
					<td><%=content %></td>
				</tr>
			</div>
		</div>
	</div>
	<div class="tab-navigation">
		<ul>
			<li><a href="#synopsis" class="tab-content active-tab">Synopsis</a></li>
			<li><a href="#cast" class="tab-content">Cast</a></li>
			<li><a href="#reviews" class="tab-content">Reviews</a></li>
		</ul>
	</div>
	<div id="tab-content">
		<div id="#synopsis-content" class="tab-content active-tab">
			<!-- synopsis content code -->
			aaa
		</div>
		<div id="#cast-content" class="tab-content">
			<!-- cast content code -->
			bbb
		</div>
		<div id="#reviews-content" class="tab-content">
			<!-- reviews content code -->
			ccc
		</div>
	</div>
<script>
	const tabs = document.querySelectorAll('.tab-navigation a');
	const tabContents = document.querySelectorAll('.tab-content');

	tabs.forEach((tab) => {
		tab.addEventListener('click', (e) => {
			e.preventDefault();
			const currentTab = e.target;
			const currentTabHref = currentTab.getAttribute('href');
			
			tabContents.forEach((tabContent) => {
				if (tabContent.getAttribute('id') === '${currentTabHref}-content') {
					tabContent.classList.add('active-tab');
				} else {
					tabContent.classList.remove('active-tab');
				}
			});
			tabs.forEach((tab) => {
				if (tab === currentTab) {
					tab.classList.add('active-tab');
				} else {
					tab.classList.remove('active-tab');
				}
		
			});
		});
	});
	</script>
</body>
</html>
