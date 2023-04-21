<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Movie Site</title>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<style>
body {
	text-align: center;
	background: #3333CC;
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
	<div class="card">
		<img
			src="https://cdn.newsculture.press/news/photo/202303/519887_640005_2853.jpg"
			alt="스즈메의 문단속" style="width: 20%">
		<div class="text-container">
			<div class="title">
				<h4>
					<b>스즈메의 문단속 </b>
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
			“이 근처에 폐허 없니? 문을 찾고 있어” 규슈의 한적한 마을에 살고 있는 소녀 ‘스즈메’는 문을 찾아 여행 중인 청년
			‘소타’를 만난다. 그의 뒤를 쫓아 산속 폐허에서 발견한 낡은 문. ‘스즈메’가 무언가에 이끌리듯 문을 열자 마을에 재난의
			위기가 닥쳐오고 가문 대대로 문 너머의 재난을 봉인하는 ‘소타’를 도와 간신히 문을 닫는다. “닫아야만 하잖아요, 여기를!”
			재난을 막았다는 안도감도 잠시, 수수께끼의 고양이 ‘다이진’이 나타나 ‘소타’를 의자로 바꿔 버리고 일본 각지의 폐허에
			재난을 부르는 문이 열리기 시작하자 ‘스즈메’는 의자가 된 ‘소타’와 함께 재난을 막기 위한 여정에 나선다. “꿈이
			아니었어” 규슈, 시코쿠, 고베, 도쿄 재난을 막기 위해 일본 전역을 돌며 필사적으로 문을 닫아가던 중 어릴 적 고향에 닿은
			‘스즈메’는 잊고 있던 진실과 마주하게 되는데…
		</div>
		<div class="tab" data-tab="tab2">
			<!-- cast content code -->
			하라 나노카 Nanoka Hara 이와토 스즈메 (일본어 목소리) 역 마츠무라 호쿠토 Matsumura Hokuto 무나카타
			소타 (일본어 목소리) 역
		</div>
		<div class="tab" data-tab="tab3" style="padding-top: 40px">
			<iframe width="750" height="422"
				src="https://tv.kakao.com/embed/player/cliplink/430418376?service=kakao_tv"
				frameborder="0" allowfullscreen></iframe>
			<div id="image-container">
				<img
					src="https://img.vogue.co.kr/vogue/2023/03/style_64084cffe607b-930x523.jpg"
					alt="Image 1">
			</div>
			<ul id="image-list">
				<li><img
					src="https://img.vogue.co.kr/vogue/2023/03/style_64084cffe607b-930x523.jpg"
					alt="Image 1"></li>
				<li><img
					src="https://img.vogue.co.kr/vogue/2023/03/style_64084d02411bc-930x523.jpg"
					alt="Image 2"></li>
				<li><img
					src="https://img.vogue.co.kr/vogue/2023/03/style_64084d6f51ce7-930x523.jpg"
					alt="Image 3"></li>
			</ul>
		</div>
		<div class="tab" data-tab="tab4">
			<canvas id="myChart"></canvas>
		</div>
		<div class="tab" data-tab="tab5">
			<h1>리뷰</h1>
			<ul id="bulletin-board">
			</ul>
			대충 리뷰
		</div>
		</div>

		<script>
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