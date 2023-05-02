<%@page import="movie.UtilMgr"%>
<%@page import="javax.swing.text.Document"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="movie.MovieBean"%>
<%@page import="java.util.ArrayList"%>
<jsp:useBean id="mgr" class="movie.MovieMgr"/>
<%
	int totalRecord = 0;	// 총 게시물 수
	int numPerPage = 30;	// 페이지당 레코드 개수 (5,10*,20,30)
	int pagePerBlock = 5;
	int totalPage = 0;		// 총 페이지 개수
	int totalBlock = 0;		// 총 블럭 개수
	int nowPage = 1;		// 현재 페이지
	int nowBlock = 1;		// 현재 블럭
	String pagegenre = "";
	
	// 요청된 numPerPage 처리
	if(request.getParameter("numPerPage")!=null){
		numPerPage = UtilMgr.parseInt(request, "numPerPage");
	}
	
	// 검색에 필요한 변수
	String keyField = "", keyWord = "";
	if(request.getParameter("keyWord")!=null){
		keyField = request.getParameter("keyField");
		keyWord = request.getParameter("keyWord");
	}
	
	// 검색 후에 다시 null 요청
	if(request.getParameter("reload")!=null&&
		request.getParameter("reload").equals("true")){
		keyField = ""; keyWord = "";
	}
	
	totalRecord = mgr.getTotalCount(keyField, keyWord);
	//out.println(totalRecord);
	
	if(request.getParameter("nowPage")!=null){
		nowPage = UtilMgr.parseInt(request, "nowPage");
	}
	// sql문에 들어가는 start, cnt 선언
	int start = (nowPage * numPerPage) - numPerPage;
	int cnt = numPerPage;
	// 전체 페이지 개수
	totalPage = (int)Math.ceil((double)totalRecord/numPerPage);
	// 전체 블럭 개수
	totalBlock = (int)Math.ceil((double)totalPage/pagePerBlock);
	// 현재 블럭 개수
	nowBlock = (int)Math.ceil((double)nowPage/pagePerBlock);
	//out.println(totalPage);
	//out.println(totalBlock);
	//out.println(nowBlock);
	
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
        .modal {
		  display: none; /* 기본적으로 모달 창을 숨긴다. */
		  position: fixed; /* 위치는 고정 */
		  z-index: 1; /* 가장 위쪽에 표시 */
		  left: 0;
		  top: 0;
		  width: 100%;
		  height: 100%;
		  overflow: auto;
		  background-color: rgba(0,0,0,0.5); /* 배경은 반투명한 검은색 */
		}
		
		/* 모달 창 스타일 */
		.modal-content {
		  background-color: #fefefe;
		  margin: 15% auto;
		  padding: 20px;
		  border: 1px solid #888;
		  width: 80%;
		  max-width: 600px;
		}

    </style>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
	<link rel="stylesheet" href="https://unpkg.com/bootstrap-icons/font/bootstrap-icons.css">
	<script type="text/javascript">
	
		function pageing(page){
			document.readFrm.nowPage.value=page;
			document.readFrm.submit();
		}
		function block(block){
			document.readFrm.nowPage.value=<%=pagePerBlock%>*(block-1)+1;
			document.readFrm.submit();
		}
		
		function check() {
			if(document.searchFrm.keyWord.value==""){
				alert("검색어를 입력하세요.");
				document.searchFrm.keyWord.focus();
				return;
			}
			document.searchFrm.submit();
		}
		
		function list() {
			document.listFrm.action = "movieList3.jsp";
			document.listFrm.submit();
		}
		
		function openModal() {
			document.getElementById("myModal").style.display = "block";
		}

		// 모달 닫기 함수
		function closeModal() {
			document.getElementById("myModal").style.display = "none";
		}
		
	</script>
</head>
<body>
<div align="center"><br/>
<header class="p-3 mb-3 border-bottom">
	<jsp:include page="header.html" />
</header>
<div class = "container">
<form name="searchFrm" style="float: right;">
       <div class="col-12 col-lg-auto mb-3 mb-lg-0 me-lg-3 d-flex align-items-center">
       	<select name="keyField" size="1" >
			<option value="title"> 제 목 </option>
			<option value="genre"> 장 르</option>
			<option value="director"> 감 독 </option>
			<option value="actor"> 배 우 </option>
			</select>
	  <input type="search" placeholder="Search" aria-label="Search" name="keyWord">
	  <button type="button" class="btn btn-primary" id="searchBtn" style="width:80px; margin-left: 10px;" onClick="javascript:check()">검색</button>
	</div>
	

	<i class="bi bi-question" onclick="openModal()" style="font-size: 1.5rem;"></i>


	<div id="myModal" class="modal">
		<div class="modal-content">
			<span onclick="closeModal()" class="close">&times;</span>
			<p>검색 가능한 장르</p>
			<p>액션, 모험, 애니메이션, 코미디, 범죄, 다큐멘터리, 드라마, 가족, 판타지, 역사, 공포, 음악, 미스터리, 로맨스, SF, TV 영화, 스릴러, 전쟁, 서부</p>
			
		</div>
	</div>
</form>
<table>
	<tr>
		<td align = "center" colspan = "2">
			<%
				ArrayList<MovieBean> vlist = mgr.getMovielist(keyField, keyWord, start, cnt);
				int listSize = vlist.size();
				if(vlist.isEmpty()){
					out.println("등록된 게시물이 없습니다.");
				}else{
			%>
				<%
				int count = 0;
					for(int i=0; i<numPerPage;i++){
						if(i==listSize) break;
						MovieBean bean = vlist.get(i);
						String title = bean.getTitle();
						String poster = bean.getPoster();
						String content = bean.getContent();
						String genre = bean.getGenre();
				if (count % 6 == 0) { %>
            <tr>
                <% } %>
                <td>
                <% if(poster.contains("https")){ %>
                	<img src="<%=poster %>">
                <% } else { %>
                	<a href="movieDetaildata.jsp?title=<%=java.net.URLEncoder.encode(title, "UTF-8")%>">
                    <img src="https://image.tmdb.org/t/p/w500<%=poster %>">
                    </a>
                <% } %>
                    <p><%=title %></p>
                </td>
                <% count++; %>
                <% if (count % 6 == 0) { %>
            </tr>
            <% } %>
				<%
					}
				%>
				</table>
			<%		
				}
			%>
		</td>
	</tr>
	<tr>
		<td colspan="2"><br><br></td>
	</tr>
	<tr>
		<td>
			<!-- 페이징 및 블럭 Start -->
			<!-- 이전블럭 -->
			<%if(nowBlock>1){%>
				<a href="javascript:block('<%=nowBlock-1 %>')">prev...</a>
			<% } %>
			<!-- 페이징 -->
			<%
				int pageStart = (nowBlock-1)*pagePerBlock+1;
				int pageEnd = (pageStart+pagePerBlock)<totalPage?
						pageStart+pagePerBlock:totalPage+1;
				for(;pageStart<pageEnd;pageStart++){
			%>
			<a href="javascript:pageing('<%=pageStart %>')">
			<%if(nowPage==pageStart){ %><font color="blue">	<%	} %>
				[<%= pageStart%>]
			<%if(nowPage==pageStart){ %></font>	<%} %>
			</a>
			<%	}	%>
			<!-- 다음블럭 -->
			<%if(totalBlock>nowBlock){%>
				<a href="javascript:block('<%=nowBlock+1 %>')">...next</a>
			<% } %>
			<!-- 페이징 및 블럭 End -->
		</td>
		<td align="right">
			<a href="javascript:list()">[처음으로]</a>
		</td>
	</tr>
</table>
</div>
<hr width="750">

<form name="listFrm" method="post">
	<input type="hidden" name="reload" value="true">
	<input type="hidden" name="nowPage" value="1">
</form>

<form name="readFrm">
	<input type="hidden" name="nowPage" value="<%=nowPage%>">
	<input type="hidden" name="numPerPage" value="<%=numPerPage%>">
	<input type="hidden" name="keyField" value="<%=keyField%>">
	<input type="hidden" name="keyWord" value="<%=keyWord%>">
	<input type="hidden" name="num">
</form>
</div>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>