<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Vector"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="movie.UtilMgr" %>
<%@ page import="movie.BoardMgr" %>
<%@ page import="movie.BoardBean" %>
<%@ page import="movie.MovieBean" %>
<jsp:useBean id="mgr" class="movie.BoardMgr"/>
<jsp:useBean id="mmgr" class="movie.MovieMgr"/>
<%
String movietitle = request.getParameter("title");
String loginedid=(String)session.getAttribute("userid");
//MovieMemberBean loginedBean=MovieMemberMgr.getMovieMember(loginedid);
int totalRecord=0;
int numPerPage=10;
int pagePerBlock=15;
int totalPage=0;
int totalBlock=0;
int nowPage=1;
int nowBlock=1;
char category='0';
String keyField = "", keyWord = "";
if(request.getParameter("numPerPage")!=null){
	numPerPage = UtilMgr.parseInt(request, "numPerPage");
}
if(request.getParameter("keyWord")!=null){
	keyField = request.getParameter("keyField");
	keyWord = request.getParameter("keyWord");
}
if(request.getParameter("reload")!=null&&
		request.getParameter("reload").equals("true")){
	keyField = ""; keyWord = "";
}
totalRecord=mgr.getBoardCount(category);
if(request.getParameter("nowPage")!=null){
	nowPage = UtilMgr.parseInt(request, "nowPage");
}
int start = (nowPage*numPerPage)-numPerPage;
int cnt = numPerPage;

totalPage=(int)Math.ceil((double)totalRecord/numPerPage);
totalBlock=(int)Math.ceil((double)totalPage/pagePerBlock);
nowBlock=(int)Math.ceil((double)nowPage/pagePerBlock);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Movie Site</title>
<script src="https://cdn.jsdelivr.net/npm/chart.js">

</script>
<style>
body {
	text-align: center;
}

.card {
	display: flex;
	display: inline-block;
	transition: 0.3s;
	width: 60%;
	margin: 10px;
}

.card:hover {
	box-shadow: 0 8px 16px 0 rgba(0, 0, 0, 0.2);
}

.title {
	text-align: left;
	padding: 2px 16px;
	font-size: 24px;
}

.container {
	text-align: left;
	padding: 2px 16px;
	column-count: 2;
}

.text-container {
	display: inline-block;
	vertical-align: top;
}

.column {
	float: left;
	width: 50%;
}

button {
	background-color: #222; /* 빨간색 */
	align: left;
	box-shadow: none;
}

nav {
	flex-wrap: wrap;
	background-color: white;
	flex-direction: column;
	overflow: hidden;
	align-items: center;
	display: flex;
	justify-content: space-between;
	margin: 0 auto;
	width: 60%;
	height: 100px;
}

nav div {
	display: flex;
	justify-content: space-between;
	width: 100%;
}

nav div:nth-child(2) {
	justify-content: center;
}

nav a {
	float: left;
	display: block;
	color: #666;
	text-align: center;
	padding: 14px 16px;
	text-decoration: none;
}

nav a:hover {
	background-color:;
}

nav input[type=text] {
	padding: 6px;
	border: none;
	background-color: gray;
	border-radius: 4px;
}

nav form {
	margin-left: 20px;
}

nav img {
	margin-left: 20px;
	margin-right: 40%;
}

nav span {
	margin-right: 20px;
	margin-left: 40%;
}

.tab-navigation {
	background-color: #f2f2f2;
	border-top: 1px solid #ccc;
	display: flex;
	justify-content: center;
	margin-top: 20px;
}

.tab-navigation ul {
	display: flex;
	list-style: none;
	margin: 0;
	padding: 0;
}

.tab-navigation a {
	color: #666;
	display: block;
	font-size: 18px;
	padding: 10px 20px;
	text-decoration: none;
}

.tab-navigation a:hover {
	background-color: #ddd;
	color: #000;
}

.tab {
	display: none;
}

div[data-tab="tab1"] {
	white-space: pre-wrap;
}

.tab.active {
	display: block;
	justify-content: center;
}

#image-list {
	display: flex;
}

#image-list img {
	top: 0;
	left: 0;
	width: 10%;
	height: 10%;
	object-fit: cover;
}

#image-container {
	width: 50%;
	height: 50%;
	object-fit: cover;
	display: flex;
	justify-content: center;
}
canvas {
  width: 200px !important;
  height: 200px !important;
}

.video-container {
  text-align: center;
}

@media ( prefers-color-scheme : dark) {
	body {
		background-color: #222;
		color: white;
	}
	nav {
		background-color: #222;
	}
	nav a {
		color: white;
	}
	nav input[type=text] {
		background-color: #333;
		color: white;
	}
	.tab-navigation {
		border-top: #222;
		background-color: #222;
	}
	.tab-navigation a {
		color: white;
	}
}
</style>
</head>
<body>
	<nav>
		<div>
			<img src="img/logo.png" alt="Logo" style="width: 75px; height: 25px;">
			<span>(12)</span>
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
<%
	MovieBean moviebean = mmgr.searchMovie(movietitle);
	String title = moviebean.getTitle();
	String poster = moviebean.getPoster();
	String content = moviebean.getContent();
	String genre = moviebean.getGenre();
	String opendt = moviebean.getOpendt();
	String age = moviebean.getAge();
	String actor = moviebean.getActor();
	String director = moviebean.getDirector();
	String playtime = moviebean.getPlaytime();
	String trailer = moviebean.getTrailer();
	
	String[] trailerArr = trailer.split(",");
%>	
	
	<div class="card">
		<img src="https://image.tmdb.org/t/p/w500<%=poster %>"
			alt="<%=title %>" style="width: 20%">
		<div class="text-container">
			<div class="title">
				<h4>
					<b><%=movietitle %></b>
				</h4>
			</div>
			<div class="container">
				<table>
					<tr>
						<td>개봉</td>
						<td><%=opendt %></td>
					</tr>
					<tr>
						<td>장르</td>
						<td><%=genre %></td>
					</tr>
					<tr>
						<td>청소년 관람불가 여부</td>
						<td><%=age %></td>
					</tr>
					<tr>
						<td>런타임</td>
						<td><%=playtime %></td>
					</tr>
					<tr>
						<td>감독</td>
						<td><%=director %></td>
					</tr>
				</table>
			</div>
		</div>
		<button>
			<img src="img/good.png" alt="Button Image" align="left">
		</button>
		<button>
			<img src="img/bad.png" alt="Button Image" align="left">
		</button>
		<button>
			<img src="img/heart.png" alt="Button Image">
		</button>
	</div>
	<div class="tab-navigation">
		<ul>
		<li><a href="#synopsis" class="tab-link" data-tab="tab1">개요</a></li>
			<li><a href="#cast" class="tab-link" data-tab="tab2">출연진</a></li>
			<li><a href="#preview" class="tab-link" data-tab="tab3">예고편</a></li>
			<li><a href="#preview" class="tab-link" data-tab="tab4">통계</a></li>
			<li><a href="#reviews" class="tab-link" data-tab="tab5">리뷰</a></li>
		</ul>
	</div>

	<div id="tab-content">
		<div class="tab active" data-tab="tab1">
			<!-- synopsis content code -->
			<%=content %>
		</div>
		<div class="tab" data-tab="tab2">
			<!-- cast content code -->
			<%=actor %>
			<p><%=trailer %></p>
		</div>
		<div class="tab" data-tab="tab3" style="padding-top: 40px">
			<div class="video-container">
			<%
				if(trailerArr.length == 0){
			%>
				<q>등록된 트레일러 영상이 없습니다</q>
			<%
				} else {
				for(int i = 0; i<trailerArr.length; i++) {
			%>
			  <div class="youtube-player" data-id="<%=trailerArr[i] %>"></div>
			<% }} %>
			  <div class="slider-buttons">
			    <button class="prev-button">이전</button>
			    <button class="next-button">다음</button>
			  </div>
			</div>
		</div>
		<div class="tab" data-tab="tab4">
			<canvas id="myChart"></canvas>
		</div>
		<div class="tab" data-tab="tab5">
			<table>
	<tr> 
		<td align="center" colspan="2">
		<%
				Vector<BoardBean> vlist =mgr.getBoardList(category);
				int listSize = vlist.size();
				if(vlist.isEmpty()){
					out.println(totalRecord+" 등록된 게시물이 없습니다.");
				}else{
		%>
			<table cellspacing="0">
				<tr align="center" bgcolor="#D0D0D0">
					<td width="100">번 호</td>
					<td width="250">제 목</td>
					<td width="100">작성자</td>
					<td width="150">작성일</td>
					<td width="100">좋아요</td>
				</tr>	
				<%
					for(int i=0;i<numPerPage/*10*/;i++){
						if(i==listSize) break;
						BoardBean bean = vlist.get(i);
						int num = bean.getBoardIdx();
						String subject = bean.getTitle();
						//String name=MovieMemberMgr.getMovieMember(bean.getUserId());
						String name = "dummy";
						String regdate = bean.getPostedDate().toString();
						//int depth = bean.getDepth();
						//int count = bean.getCount();
						//String filename = bean.getFilename();
						int ccount=mgr.getCommentCount(num);
						int lcount=bean.getLiked();
				%>
				<tr align="center">
					<td><%=totalRecord-start-i%></td>
					<td align="left">
					<%//for(int j=0;j<depth;j++){out.println("&nbsp;&nbsp;");} %>
					<a href="javascript:read('<%=num%>')">
					<%=subject%></a>
					<!-- <%//if(filename!=null&&!filename.equals("")){ %>
						<img alt="첨부파일" src="img/icon.gif" align="middle">	
					<%//}%> -->
					<%if(ccount>0){ %>
					<font color="black">[<%=ccount %>]</font>
					<%} %>
					</td>
					<td><%=name%></td>
					<td><%=regdate%></td>
					<td><%=lcount%></td>
				</tr>
				<%}//--for	%>
			</table>
		<%}//--if-else%>	
			</table>
		</div>
		</div>

		<script>
		(function() {
			  var youtube = document.querySelectorAll(".youtube-player");
			  for (var i = 0; i < youtube.length; i++) {
			    var source = "https://img.youtube.com/vi/"+ youtube[i].dataset.id +"/sddefault.jpg";
			    var image = new Image();
			    image.src = source;
			    image.addEventListener( "load", function() {
			      youtube[ i ].appendChild( image );
			    }( i ) );
			    youtube[i].addEventListener( "click", function() {
			      var iframe = document.createElement( "iframe" );
			      iframe.setAttribute( "frameborder", "0" );
			      iframe.setAttribute( "allowfullscreen", "" );
			      iframe.setAttribute( "width", "1000" ); // width 속성 추가
			      iframe.setAttribute( "height", "800" ); // height 속성 추가
			      iframe.setAttribute( "src", "https://www.youtube.com/embed/"+ this.dataset.id +"?rel=0&showinfo=0&autoplay=1" );
			      this.innerHTML = "";
			      this.appendChild( iframe );
			    } );
			  };
			})();
		
  const tabLinks = document.querySelectorAll('.tab-navigation a');
  const tabContents = document.querySelectorAll('.tab');
  
  

  function setActiveTab(event) {
	    // 현재 클릭한 버튼의 data-tab 속성 값을 가져옵니다.
	    const targetTab = event.target.getAttribute('data-tab');
	    
	    tabContents.forEach(tab => tab.classList.remove('active'));

	    // 각 탭의 내용을 숨깁니다.
	   for (let i = 0; i < tabContents.length; i++) {
      if (tabContents[i].getAttribute('data-tab') === targetTab) {
        tabContents[i].classList.add('active');
      }
    }
		
}

	  // 버튼에 클릭 이벤트를 등록합니다.
	  for (let i = 0; i < tabLinks.length; i++) {
	    const tabLink = tabLinks[i];
	    tabLink.addEventListener('click', setActiveTab);
	  }
	  
	  const imageContainer = document.querySelector('#image-container');
	  const imageList = document.querySelector('#image-list');

	  imageList.addEventListener('click', (event) => {
	    if (event.target.tagName === 'IMG') {
	      const newImageSrc = event.target.src;
	      const imageContainerImg = imageContainer.querySelector('img');
	      imageContainerImg.src = newImageSrc;
	    }
	  });
	  
	  //원형차트 만들기
	  var ctx = document.getElementById('myChart').getContext('2d');
	    var myChart = new Chart(ctx, {
	        type: 'pie', // 차트 종류 (원형 차트)
	        data: {
	            labels: ['Red', 'Blue', 'Yellow'], // 라벨
	            datasets: [{
	                label: '# of Votes',
	                data: [12, 19, 3], // 데이터
	                backgroundColor: [
	                    'rgba(255, 99, 132, 0.2)', // 색상
	                    'rgba(54, 162, 235, 0.2)',
	                    'rgba(255, 206, 86, 0.2)'
	                ],
	                borderColor: [
	                    'rgba(255, 99, 132, 1)', // 선 색상
	                    'rgba(54, 162, 235, 1)',
	                    'rgba(255, 206, 86, 1)'
	                ],
	                borderWidth: 1 // 선 굵기
	            }]
	        },
	        options: {
	        	responsive: true,
	            scales: {
	                y: {
	                    beginAtZero: true // Y축 값이 0부터 시작    		 
	                }
	            }
	        }
	    });
	    myChart.update();		
</script>
</body>
</html>