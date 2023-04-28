<%@page contentType="text/html; charset=UTF-8"%>
<%
		
%>
<!-- 상단 네비게이션 바 -->
        
        <nav class="navbar navbar-expand-lg bg-light">
  <div class="container-fluid">
   
    <div class="collapse navbar-collapse" id="navbarSupportedContent">
      <ul class="navbar-nav me-auto mb-2 mb-lg-0">
        <li class="nav-item">
          <a class="nav-link active" aria-current="page" href="crawlTest.jsp">홈</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="#">영화</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="rankingPage.jsp">랭킹</a>
        </li>
        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
            게시판
          </a>
          <ul class="dropdown-menu">
            <li><a class="dropdown-item" href="#">사용자 게시판</a></li>
            <li><a class="dropdown-item" href="#">토론 게시판</a></li>
          </ul>
        </li>
        <li class="nav-item">
          <a class="nav-link"  href="recommend_movie.jsp">추천</a>
        </li>
      </ul>
      <form class="d-flex" role="search">
        <input class="form-control me-2" type="search" placeholder="Search" aria-label="Search">
        <button class="btn btn-outline-success" type="submit">검색</button>
      </form>
    </div>
  </div>
</nav>