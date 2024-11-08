<%@ page session="false"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
	language="java"%>
	
<html>
<head>
 <script src="https://code.jquery.com/jquery-latest.min.js"></script>

<title>Home</title>
</head>
<body>
	<p style="padding-top: 25px; padding-bottom: 25px;">회원가입</p>
	<a href="/">
		<h1>넌 아직 준비가 안됐다</h1>
	</a>
	
	<hr></hr>
	<div class="container" style="margin-top: 5%; margin-left: 10%;">
		<form>
			<label for="userId">ID:</label> 
			<input type="text" id="userId" required>
			<button onclick="idcheck()">중복체크</button>
			<p></p>
			<label for="password">비밀번호:</label> 
			<input type="password" id="password" name="password" required>
			<span style="color:gray;">비밀번호는 대문자, 소문자, 숫자, 특수문자를 각각 한 글자 이상 포함해야 하며, 8글자 이상이어야 합니다.</span>
			<p></p>
			<label for="passwordcheck">비밀번호 체크:</label> <input type="text"
				id="passwordcheck" required>
			<p></p>
			<label for="username">이름:</label> 
			<input type="text" id="username" name="userName" required>
			<p></p>
			<label for="firstEmail">이메일:</label> <input type="text" id="email"
				name="firstEmail" required>@ <input type="text"
				id="lastEmail" name="lastEmail" required>
			<p></p>
			<label for="phoneNumber">휴대폰:</label> 
			<select id="phoneNumber1"name="phoneNumber1">
				<option value="010">010</option>
				<option value="011">011</option>
				<option value="016">016</option>
				<option value="017">017</option>
				<option value="018">018</option>
			</select>- <input type="number" id="phoneNumber2" name="phoneNumber2" required>-
			<input type="number" id="phoneNumber3" name="phoneNumber3" maxlength="4" required>
			<p></p>
			<label for="gender">성별:</label> 
			<label><input type="radio" id="male" name="gender" value="남성">남성</label>
			<label><input type="radio" id="female" name="gender"value="여성">여성</label>
			<p></p> 
			<label for="fistResidentNumber">주민등록번호:</label> 
			<input type="text" id="fistResidentNumber" name="fistResidentNumber" required>-
			<input type="text" id="lastResidentNumber" name="lastResidentNumber" maxlength="7" required>
			<p></p>
			<label for="address">주소:</label>
			<input type="text" id="address" name="address" required>
			<p>*주소는 (시/도)만 입력해주세요(예: 경기도, 서울특별시, 경상남도 등)</p>
			<hr></hr>
			<div style="margin-left:35%; margin-top:2%">
					<button onclick="membershipCheck()">가입신청</button>
					<button type="reset">다시입력</button>
					<button>취소</button>
			</div>
		</form>
	</div>
	<script>
	var nextable = false;
	
	
	
	
		//id 중복검사 마쳤는지 확인
		var loginable = false;
		//다음걸로 넘어갈 수 있는지 확인
		
	
		function membershipCheck() {
			event.preventDefault();
		    var password = $('#password').val();
		    var passwordCheck = $('#passwordcheck').val();
		    
	        var 소문자 = /[a-z]/;
	        var 대문자 = /[A-Z]/;
	        var 숫자 = /[0-9]/;
	        var 특수문자 = /[~!@#$%^&*()_+|<>?:"{},./;'[\]\\-]/;
	        
		    if (password === passwordCheck) {
		        if (password.length < 8) {
		            alert("비밀번호는 8글자 이상이어야 합니다");
		            return;
		        } 
		        
		       

		        if (!대문자.test(password)) {
		            alert("비밀번호에는 대문자가 하나 이상 들어가야 합니다");
		            return;
		        } 
		        
		        if (!소문자.test(password)) {
		            alert("비밀번호에는 소문자가 하나 이상 들어가야 합니다");
		            return;
		        } 
		        
		        if (!숫자.test(password)) {
		            alert("비밀번호에는 숫자가 하나 이상 들어가야 합니다");
		            return;
		        }

		        if (!특수문자.test(password)) {
		            alert("비밀번호에는 특수문자가 하나 이상 들어가야 합니다");
		            return;
		        }

		        alert("회원가입 되었습니다.");
		        nextable =true;
		        $(function(){
		    		if(nextable == true){
		    			$('a').attr("href","/checkstudy");
		    			$('a>h1').text("다음 강의로 이동하기");
		    		}
		    		
		    	});
		    } else {
		        alert("비밀번호가 일치하지 않습니다.");
		    }
		}

		

		//id유효성체크
		function idcheck() {
			event.preventDefault();
			var id = $('#userId').val();
			var userid = "test";
			var regex = /^[a-zA-Z0-9]*$/;

			if (!regex.test(id)) {
				alert("ID는 영문과 숫자만 입력 가능합니다.");
				return;
			}

			if (id === userid) {
				alert("이미 사용중인 ID입니다.");
			} else {
				alert("사용 가능한 ID입니다.");
				loginable=true;
			}
		}

		//이름 글자수 체크
		$('#username').on('input',
				function() {
					var inputField = $(this);
					var inputLength = inputField.val().length;
					var maxLength = 5;
					if (inputLength > maxLength) {
						alert("최대 글자수를 초과했습니다.")
					}
				}
		);

		//휴대폰 번호 4자리 이후 커서 이동
		$('#phoneNumber2').on('input',
				function() {
					var inputField = $(this);
					var inputLength = inputField.val().length;
					var maxLength = 4;
					if (inputLength >= maxLength) {
						$('#phoneNumber3').focus();
					}
				});

		//휴대폰 번호 4자리 이후 슬라이스
		$('#phoneNumber3').on('input', function() {
							var inputField = $(this);
							var inputLength = inputField.val().length;
							var maxLength = 4;
							if (inputLength >= maxLength) {
								inputField.val(inputField.val().slice(0,
										maxLength));
								
							}
						});

		//주민등록번호 앞자리 8자리 이후 뒷자리로 커서 이동
		$('#fistResidentNumber').on('input',
				function() {
					var inputField = $(this);
					var inputLength = inputField.val().length;
					var maxLength = 7;

					if (inputLength >= maxLength) {
						$("#lastResidentNumber").focus();
					}
				});

		//주민번호 뒷자리 1이후 마스킹처리, 9글자로 제한
		$('#lastResidentNumber')
				.on('input',function() {
							var lastresidentNumber = $(this);
							var inputLength = lastresidentNumber.val().length;
							var maxLength = 7;

							if (inputLength > 1) {
								var maskedValue = lastresidentNumber.val().charAt(0)
										+ "*".repeat(inputLength - 1);
								lastresidentNumber.val(maskedValue);
							}

							if (inputLength >= maxLength) {
								inputField.val(inputField.val().slice(0,
										maxLength));
							}
						});
	</script>
</body>
</html>
