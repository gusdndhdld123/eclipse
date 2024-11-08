<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
	language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>

<html>
<head>
<title>checkStudy</title>
</head>
<body>
	<div class="container" style="content-align: center;">
		<div>
			<label for="all">
				<input type="checkbox" class="mainCheckbox" id="all">전체
			</label>
			<button onclick="button()">버튼</button>
		</div>
		<div>
			<label for="seoul">
				<input type="checkbox" class="subCheckbox" id="서울">서울
			</label>
			<label for="incheon">
				<input type="checkbox" class="subCheckbox" id="인천">인천
			</label>
			<label for="gyeonggi">
				<input type="checkbox" class="subCheckbox" id="경기">경기
			</label>
			<label for="gangwon">
				<input type="checkbox" class="subCheckbox" id="강원">강원
			</label>
			<label for="busan">
				<input type="checkbox" class="subCheckbox" id="부산">부산
			</label>
			<label for="daejeon">
				<input type="checkbox" class="subCheckbox" id="대전">대전
			</label>
			<label for="jeonnam">
				<input type="checkbox" class="subCheckbox" id="전남">전남
			</label>
			<label for="jeju">
				<input type="checkbox" class="subCheckbox" id="제주">제주
			</label>
			<label for="pyongyang">
				<input type="checkbox" class="subCheckbox" id="평양">평양
			</label>
		</div>
		<hr></hr>
		<div style="backgroudColor : gray;">
			<div>
				<p>체크한 지역 목록</p>
			</div>
			<div id="checkList">
				<ul id="list"></ul>
			</div>
		</div>
	</div>
	<script>
	let checkedboxList = [];
	
	const subCheckbox = $('.subCheckbox');
	const mainCheckbox= $('#all');
	
	//전체 체크박스 체크 여부에 따른 지역 체크박스 체크 동작
	mainCheckbox.on('change', function(){
		//체크박스 리스트 초기화
		checkedboxList = [];
		subCheckbox.forEach(function (checkbox){
			
			if(mainCheckbox.checked){
				checkbox.checked = true;
				 if (!checkedboxList.includes(checkbox.id)) {
		                checkedboxList.push(checkbox.id);
		            }
			}else{
				checkbox.checked = false;
			}
		});
	});
	//지역 체크박스가 전부 체크될 시 전체 체크박스 체크 동작
	subCheckbox.forEach(function(checkbox){
		checkbox.addEventListener('change', function(){
			if(Array.from(subCheckbox).every(cb => cb.checked)){
				mainCheckbox.checked = true;
			}else{
				mainCheckbox.checked = false;
			}
		});
	});
	
	//지역 체크박스를 체크할 때, 만들어둔 checkedboxList에 추가, 해제할 때 삭제하기
	subCheckbox.forEach(function(checkbox){
		checkbox.addEventListener('change', function(){
			if(checkbox.checked){
				checkedboxList.push(checkbox.id);
			}else{
				index = checkedboxList.indexOf(checkbox.id);
				checkedboxList.splice(index, 1);
			}
		});
	});
	
	//버튼을 눌렀을 때 실행되는 함수
	function button(){
		event.preventDefault();
		if(mainCheckbox.checked){//메인체크박스가 눌려있을 때
			alert("성공")
		}else{//메인체크박스가 눌려있지 않고, 체크박스리스트의 갯수가 4개 이하일 때
			if(checkedboxList.length <5){
				alert("성공")
			}else {//메인체크박스가 눌려있지 않고, 체크박스의 갯수가 5개 이상일 때
				alert("실패")
			}
		}
	}
	//subCheckbox를 눌렀을 때 checkedboxList를 웹에 보여주는 코드
	subCheckbox.forEach(function(checkbox){
		checkbox.addEventListener('change', function(){
			let checkList = document.querySelector('#checkList');
			checkList.innerHTML = '';
			// 체크된 항목을 HTML 리스트 항목으로 변환
	        checkedboxList.forEach(function(id) {
	            const listItem = document.createElement('li');
	            listItem.textContent = id;
	            checkList.appendChild(listItem);
	        });
		});
	});
	//mainCheckbox를 눌렀을 때 전체 리스트 보이기, 다시 눌렀을 때 초기화하기
	mainCheckbox.addEventListener('change', function(){
		let checkList = document.querySelector('#checkList');
		checkList.innerHTML = '';
		if(mainCheckbox.checked){
			// 체크된 항목을 HTML 리스트 항목으로 변환
	        checkedboxList.forEach(function(id) {
	            const listItem = document.createElement('li');
	            listItem.textContent = id;
	            checkList.appendChild(listItem);
	        });
		}else{
			index = checkedboxList.indexOf(checkbox.id);
			checkedboxList.splice(index, 1);
		}
		
	});
	
	</script>
</body>
</html>