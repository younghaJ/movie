<!-- movieMember.jsp -->
<%@page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="mgr" class="movie.MovieMemberMgr"/>

<html>

<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<title>Movie Member</title>
</head>


<div align = "center">
<form name = "join" method="post" action = "memberJoin" onsubmit="return validateId()&&validatePassword()&&validateNickname()&&passwordequals();">
<h1>회원가입</h1>
<div>
	<label>아이디</label>
	<input name="userid" id="userid" class="input_id" size="15" required>
	<font id = "checkId" size="2"></font>	
	 
</div>
<br>
<div>	
	<label>닉네임</label>
	<input name="usernn" id="usernn" class="input_nn" size="15" required>
	<font id = "checkNname" size="2"></font>
	
</div>
<br>
<div>	
	<label>비밀번호</label>
	<input type="password" id="userpwd" name="userpwd" class="pw" size="15" required>	
</div>
<br>
<div>	
	<label>비밀번호 확인</label>
	<input type="password" id="userpwdCheck" name="pwdCheck" class="pw" size="15" required>	
	<font id="checkPw" size="2"></font>
</div>
<br>
<div>	
	<label for="year">년도:</label>
	<select id="birth" name="birth" required></select>
	
	<script>
	  var currentYear = new Date().getFullYear();
	  var startYear = 1900;
	  var select = document.getElementById("birth");
	  for(var i = currentYear; i >= startYear; i--) {
	    var option = document.createElement("option");
	    option.value = i;
	    option.text = i;
	    select.add(option);
	  }
	</script>
		
</div>

<br>
<div>	
	<label>성별</label>
	남<input type="radio" name="gender" value="1" size="15" required>
	여<input type="radio" name="gender" value="0" size="15" required>	
</div>
<br>
<div>	
	<button type="submit">회원가입 완료</button>
	
</div>
</form>
</div>
		
<script>
	var $j = jQuery.noConflict();
	$j('.input_id').keyup(function(){ //keyup 은 키보드에서 손을 떼어냈을때 이벤트 발생
		let userid = $j('.input_id').val(); //input_id에 입력되는 값
		
		$j.ajax({
			url :"/movieProject/idCheck",
			type : "post",
			data : {userid:userid},
			dataType : 'json',
			success : function(result){
				if(result==0){
					$j("#checkId").html('사용할 수 없는 아이디입니다.');
					$j("#checkId").attr('color','red');
				}else if(result==1){
					$j("#checkId").html('사용할 수 있는 아이디입니다.');
					$j("#checkId").attr('color','green');
				}else{
					$j("#checkId").html('아이디를 입력해주세요.');
					$j("#checkId").attr('color','black');
				}
			},
			error :  function () {
				alert("서버요청실패");
				
			}
		})
	})
	
	$j('.input_nn').keyup(function(){
		let usernn = $j('.input_nn').val(); //input_nn에 입력되는 값
		
		$j.ajax({
			url :"/movieProject/nnCheck",
			type : "post",
			data : {usernn:usernn},
			dataType : 'json',
			success : function(result){
				if(result==0){
					$j("#checkNname").html('사용할 수 없는 닉네임입니다.');
					$j("#checkNname").attr('color','red');
				}else if(result==1){
					$j("#checkNname").html('사용할 수 있는 닉네임입니다.');
					$j("#checkNname").attr('color','green');
				}else{
					$j("#checkNname").html('닉네임을 입력해주세요.');
					$j("#checkNname").attr('color','black');
				}
			},
			error :  function () {
				alert("서버요청실패");
				
			}
		})
	})
	
	$j('.pw').keyup(function (){
		let userpwd = $j("#userpwd").val();
		let userpwdCheck = $j("#userpwdCheck").val();
		
		if(userpwd != "" || userpwdCheck !=""){
			if(userpwd == userpwdCheck){
				$j("#checkPw").html('일치');
				$j("#checkPw").attr('color','green');
			}else {
				$j("#checkPw").html('불일치');
				$j("#checkPw").attr('color','red');
				
			}
		} 
		
	})
	
	// 비밀번호 유효성 검사
	function validatePassword() {
	  const password = document.getElementById("userpwd").value;
	  const passwordRegex = /^(?=.*[0-9])(?=.*[a-zA-Z])([a-zA-Z0-9]+){6,}$/;
	  if (!passwordRegex.test(password)) {
	    alert("비밀번호는 알파벳과 숫자를 혼합한 6자 이상의 문자열이어야 합니다.");
	    return false;
	  }
	  return true;
	  
}
	
	// 아이디 유효성 검사
	function validateId() {
	  const userid = document.getElementById("userid").value;
	  const idRegex = /^(?=.*[0-9])(?=.*[a-zA-Z])([a-zA-Z0-9]+){6,}$/;
	  if (!idRegex.test(userid)) {
	    alert("아이디는 알파벳과 숫자를 혼합한 6자 이상의 문자열이어야 합니다.");
	    return false;
	  }
	  return true;
	  
}
	// 닉네임에는 특수문자 입력 불가
	function validateNickname() {
	  const nicknameInput = document.getElementById("usernn");
	  const nickname = nicknameInput.value.trim();
	  const specialChars = /[~!@#$%^&*()+=[\]{}\\|;:'",.<>/?]/;
	  if (specialChars.test(nickname)) {
	    alert("닉네임에 특수문자는 입력할 수 없습니다.");
	    nicknameInput.focus();
	    return false;
	  }
  		return true;
	
	}
	
	// 비밀번호, 비밀번호확인 불일치면 가입 안됨.
	function passwordequals() {
		const userpwd = document.getElementById("userpwd").value;
		const userpwdCheck =document.getElementById("userpwdCheck").value;
		if(userpwd != userpwdCheck){
			alert("비밀번호를 확인해주세요.");
			return false;
		}
		return true;
		
	}
</script>
</html>