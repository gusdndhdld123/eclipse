<%@ page session="false"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
	crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-latest.min.js"></script>

<meta charset="utf-8">
<title>codingTest</title>

</head>

<body>
	<div>
		<div id="modal0" style="display: none">모달창0</div>
		<div id="modal1" style="display: none">모달창1</div>
		<div id="modal2" style="display: none">모달창2</div>
		
		<button id="button0">버튼0</button>
		<button id="button1">버튼1</button>
		<button id="button2">버튼2</button>
		
		
		
		<button onclick="prac1()">연습문제 1</button>
		<button onclick="prac2()">연습문제 2</button>
		<button onclick="prac3()">연습문제 3</button>
		<button onclick="prac4()">연습문제 4</button>
		<button onclick="prac5()">연습문제 5</button>
		<button onclick="prac6()">연습문제 6</button>
		<button onclick="prac7()">연습문제 7</button>
	</div>
	<script>
		
		const prac1 = () => {
			var 데이터 = {
					num : [10, 20, 30, 40, 50]
				}	
			console.log(데이터.num[4]*3);
		}	
		
		const prac2 = () =>{
			setTimeout(() => {
				console.log( 'javascript es6' );
			}, 2000); 
		}
		
		
		const prac3 = () => {
		    for (let i = 0; i < 5; i++) {
		        setTimeout(() => {
		            console.log(i + 1);
		        }, 1000 * i);
		    }
		};
		
		const prac4 = () => {
			var numbers = [4, 6, 1, 2, 3, 3, 4, 5, 9];
			const maxnum = Math.max(...numbers);
			console.log(maxnum);
		}
		
		const prac5 = () => {
			var data = 'orange';
			const arr = [...data].sort();
			
			console.log(arr);
		}
		
		const prac6 = () => {
			function arr(...rest){
				return [...rest];
			}
			var newArray = arr(1,2,3,4,5);
			console.log(...newArray); 
			//	결과는 1 2 3 4 5 출력
		}
		
		const prac7 = () => {
			var a = [1,2,3];
			var b = ['you', 'are'];
			var c = function(a,b){
			  console.log( [[...a], ...[...b]][1] )
			  console.log([[...a],...[...b]])
			  console.log([[...a],[...b]])
			  console.log([[...a],[...b]][1])
			}
			c(a,b);
		}
		
		const hidemodal = () => {
			$('#modal0').css("display", "none");
			$('#modal1').css("display", "none");
			$('#modal2').css("display", "none");
		}

		
		const showmodal = (id) => {
			hidemodal();
			
			const modalid = '#modal'+id;
		    console.log(modalid); 
		    
		    $(modalid).css("display", "block");
		}


		
		$('#button0').on('click', function() {
			showmodal(0); 
		});
		$('#button1').on('click', function() {
			showmodal(1); 
		});
		$('#button2').on('click', function() {
			showmodal(2); 
		});
	</script>
</body>
</html>
