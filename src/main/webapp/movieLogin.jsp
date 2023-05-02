<!-- movielogin.jsp -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
<title>Movie login</title>
<link rel="stylesheet" href="./movie.css" />
</head>
<!-- <body topmargin="100" > -->
<form method="post" action="/movieProject/movieProject/loginServlet">
<div align = "center">
<div class="logo">
	<img src="./img/logo1.png">
</div>
<div>
<h1>로그인</h1>
</div>
<div>
	<label>아이디</label>
	<input name="userid" id="userid" class="input_id" size="15" required>
</div>
<div>	
	<label>비밀번호</label>
	<input type="password" id="userpwd" name="userpwd" class="pw" size="15" required>	
</div>
<br>
<div>
<button type="submit">로그인</button>&nbsp;
<button onclick="javascript:location.href='movieMember.jsp'">회원가입</button>

</div>
<br>

<div>

 <a href="javascript:kakaoLogin()"><img src="./img/kakao_login_btn.png"/ style="height: 50px;width: auto;"></a>
</div>
</form>
</body>

</html>