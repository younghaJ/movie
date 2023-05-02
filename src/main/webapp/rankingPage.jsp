<%@page import="movie.MovieBean"%>
<%@page import="movie.RankMgr"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>

<%@page contentType="text/html; charset=UTF-8"%>
<%
	//	HttpSession session = request.getSession();
		RankMgr rmgr = new RankMgr();
		String userId = (String)session.getAttribute("userId");
		String changeText = "예매 순위";

		List<MovieBean> rankList = new ArrayList<MovieBean>();
		rankList = rmgr.rankingMovie();
%>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script type="text/javascript" src="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>
<link rel="stylesheet"  href="css/rankingPage.css">
<link rel="stylesheet" type="text/css" href="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css"/>

</head>
<script >
const change = (num) => {
    const tabList = document.querySelectorAll(".tab");
    tabList.forEach((el) => (el.style.display = "none"));
    const nowTab = document.querySelector(".tab" + num);
    nowTab.style.display = "block";
    if (num =="2") {
    	$('.netf_ol').slick({
		    slidesToShow: 5,
		    slidesToScroll: 5,
		    prevArrow: $('.prevNetf'),
		    nextArrow: $('.nextNetf')
		  });
		  $('.prevNetf').click(function(){
		      $('.netf_ol').slick('slickPrev');
		    });
		  $('.nextNetf').click(function(){
		      $('.netf_ol').slick('slickNext');
		    });
		  
			$('.disney_ol').slick({
			    slidesToShow: 5,
			    slidesToScroll: 5,
			    prevArrow: $('.prevDisn'),
			    nextArrow: $('.nextDisn')
			  });
			  $('.prevDisn').click(function(){
			      $('.disney_ol').slick('slickPrev');
			    });
			  $('.nextDisn').click(function(){
			      $('.disney_ol').slick('slickNext');
			    });
	}
  };
</script>
<body>
	<div>
	  <!-- 로고 및 사용자 닉네임 표출 -->
        <div class="top_css">
        	<div>
        		<div class="logo">
					<img src="img/logo1.png" width="200px" height="70px">
				</div>
        	</div>
        	<div class = " state"><div class="border border-light border-4 rounded" id="div_state" >
        	<%if(userId == null) {%>
        		<a href="posterTest.jsp">로그인</a>
        		<% }else{%>
        		<a href="myPage.jsp"><%=userId %>   님</a>
        		<%} %>
        	</div></div>
        </div>	
        <!-- APPBAR -->
        <%@ include file="navbar.jsp" %>
	<div class= "rank_body container-md">
		<div>
			<div>
				<div class="text_div col-sm-4">
					<div><p id = "currentRank" class="font_span fs-3 fw-bolder" onclick="change(1)" >예매 순위</p></div>
					<div><p id="ottRank" class="font_span fs-3 fw-bolder" onclick="change(2)" >OTT</p></div>
				</div>
				<div class="rankList_container rounded  border  border-light border-3" >
					<!-- 상영중인 영화 -->
					<div class="tab tab1">
						<ol class="first row">
					<%
					for(int i=0;i<5;i++){
					MovieBean rankBean = rankList.get(i);					
					%>
							<li class="col rank_li"><div class="movie_div" ><a href="board.jsp?title=<%= rankBean.getTitle()%>">
							<div class="poster<%=i%> pst" ><img class="pst" alt="no-img" src="<%=rankBean.getPoster()%>" width = "150" height = "250"></div>
							<div class="title<%=i %>"><font style="font-weight: bold;"><%=i+1%>&nbsp;&nbsp;<%=rankBean.getTitle() %></font></div>
							</div></a></li>							
							<%} %>
						</ol>
						<ol class="second row" start="6">
						<%
						for(int i=5;i<rankList.size();i++){
							MovieBean rankBean = rankList.get(i);
						%>
							<li class="col rank_li"><div class="movie_div" ><a href="board.jsp?title=<%= rankBean.getTitle()%>">
								<div class="poster<%=i%> pst"><img class="pst" alt="no-img" src="<%=rankBean.getPoster()%>" width = "150" height = "250"></div>
							<div class="title<%=i %>"><font style="font-weight: bold;"><%=i+1%>&nbsp;&nbsp;<%=rankBean.getTitle() %></font></div>
							</div></a></li>		
							<%} %>
						</ol>
					</div>
					<!-- 상영중인 영화 끝-->
					<!-- ott  -->
						<div class="tab tab2" style="display: none;" >
						<div class="netflix">
							<div class="bg-secondary bg-gradient bg-opacity-40"><h3>Netflix</h3></div>
							<ol class="netf_ol" style="display: flex;">
						<% 
						List<String> netfList = new ArrayList<String>();
						netfList = rmgr.getNetflixTop();
						for(int i=0; i<netfList.size();i++){
							String nTitle = netfList.get(i);
							MovieBean netfBean = rmgr.getOttTop(nTitle);
						%>
							<li>
							<!-- @@넷플릭스 포스터 타이틀 -->
								<div class="movie_div" ><a href="board.jsp?title=<%=netfBean.getTitle() %>">
									<div class="poster<%=i%> pst"><img class="pst" alt="no-img" src="<%=netfBean.getPoster()%>" width = "150" height = "250"></div>
									<div class="title<%=i %>"><font style="font-weight: bold;"><%=i+1%>&nbsp;&nbsp;<%=netfBean.getTitle() %></font></div>					
								</a></div>
							</li>
							<% }%>
						</ol>
						<button class="prevNetf" style="display: inline-block;">Prev</button>
						<button class="nextNetf" style="display: inline-block;">Next</button> 
						</div>
						
						<div class="Disney">
							<div class="bg-secondary bg-gradient bg-opacity-40"><h3>Disney+</h3></div>
							<ol class="disney_ol" style="display: flex;">
						<% 
						List<String> disneyList = new ArrayList<String>();
						disneyList = rmgr.getDisneyTop();
						for(int i=0; i<disneyList.size();i++){
							String nTitle = disneyList.get(i);
							MovieBean disBean = rmgr.getOttTop(nTitle);
						%>
							<li>
								<div class="movie_div" ><a href="board.jsp?title=<%=disBean.getTitle() %>">
							<!-- @@디즈니 포스터 타이틀 -->
									<div class="poster<%=i%> pst"><img class="pst" alt="no-img" src="<%=disBean.getPoster()%>" width = "150" height = "250"></div>
									<div class="title<%=i %>"><font style="font-weight: bold;"><%=i+1%>&nbsp;&nbsp;<%=disBean.getTitle() %></font></div>					
								</a></div>
							</li>
							<% }%>
						</ol>
						<button class="prevDisn" style="display: inline-block;">Prev</button>
						<button class="nextDisn" style="display: inline-block;">Next</button> 
						</div>
						
					</div>
					<!-- ott 끝 -->
									
				</div>
			</div>
		</div>
	</div>
	
	</div><!-- rank body -->
</body>
</html>
