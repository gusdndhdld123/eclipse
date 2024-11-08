<%@ page session="false"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
	language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<html>
<head>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
	crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-latest.min.js"></script>
<style type="text/css">
.table {
	border-collapse: collapse;
	width: 100%;
}

.table th, .table td {
	border: 1px solid black;
	padding: 8px;
	text-align: left;
}

.table th {
	background-color: #f2f2f2;
}
</style>
<meta charset="utf-8">
<title>BoardList1</title>

</head>
<script>
$(document).ready(function() {
    // 페이지 로딩 시에 변수 값 가져오기
    var keyword = $('#keyword').val();
    var searchType = $('#searchType').val();
    var startDate = $('#startDate').val();
    var endDate = $('#endDate').val();
    var pageIndex = $('#pageIndex').val();
    var pageSize = $('#pageSize').val();
    // 전송할 데이터를 객체(Map) 형태로 구성
    var requestData = {
        "keyword": keyword,
        "searchType": searchType,
        "startDate": startDate,
        "endDate": endDate,
        "pageIndex": pageIndex,
        "pageSize" : pageSize
    };
    
    // Ajax 요청
    $.ajax({
        url: "/list1",
        type: "POST",
        data: JSON.stringify(requestData),
        contentType: "application/json",
        success: function(result) {
            alert("리스트 불러오기 성공");
			
            
            var tbody = $('#table1 tbody');
            tbody.empty(); 

            // 결과를 사용하여 새로운 행 추가
            result.boardList.forEach(function(board) {
                var row = document.createElement('tr');

                row.innerHTML = 
                    '<td><input type="checkbox" class="seq" value="' + board.seq + '"></td>' +
                    '<td>' + board.seq + '</td>' +
                    '<td>' + board.memId + '</td>' +
                    '<td>' +
                        '<a onclick="changeRead(' + board.seq + ')" style="color:blue; cursor:pointer;">' + board.boardSubject + '</a>' +
                    '</td>' +
                    '<td>' + board.regDate + '</td>' +
                    '<td>' + board.uptDate + '</td>' +
                    '<td>' + board.viewCnt + '</td>';


                document.querySelector('tbody').appendChild(row);
            });

        },
        error: function() {
            alert("리스트 불러오기 실패");
        }
    });
});



</script>

<body>
	<div id="boardList">
		<div class="container-fluid" style="text-aline: center;">
			<div style="padding: 1%;">
				<a href="/list1">
					<h1>BoardList</h1>
				</a>
			</div>
			<div style="width : 100%;">
				<form class="search-form"
					style="width: 100%; padding-left: 10%;" autocomplete="off" id="searchForm">
					<div style="display:none">
						<input type="text" name="pageIndex" id="pageIndex" value="1">
						<input type="text" value="10" name="pageSize" id="pageSize" value="10">
					</div>
					<table style="width: 100%;">
						<tbody>
							<tr class="row">
								<td class="col-2">
									시작 날짜 : 
								</td>
								<td class="col-4">
						            <input type="date" class="form-control" name="startDate" value="${map.startDate}" id="startDate">
								</td>
								<td class="col-2">
									끝 날짜 : 
								</td>
								<td class="col-4" >
						            <input type="date" class="form-control" name="endDate" value="${map.endDate}" id="endDate">
								</td>
							</tr>
							<tr class="row">
								<td class="col-3">
									<select id="searchType" name="searchType" class="form-control" style="text-aline: center;">
										<option value="">선택하기</option>
										<option value="subject">제목</option>
										<option value="content">내용</option>
										<option value="writer">작성자</option>
										<option value="all">제목+내용+작성자</option>
									</select>
								</td>
								<td class="col-6">
								<input type="text" class="form-control"	placeholder="번호,ID,제목 등을 입력해주세요" name="keyword" id="keyword"
									value="${map.keyword}"requird></td>
								<td class="col-3">
									<button class="btn btn-primary" id="searchbtn">검색</button>
								</td>
							</tr>
							
						</tbody>
					</table>
				</form>
				
			</div>
			<div style="display: flex; align-items: right;">
				<button class="btn-primary" onclick="changeInsert()">글쓰기</button>
				<button class="btn btn-danger" onclick="deleteBoards()">삭제</button>
			</div>
			<table class="table" border="1" id="table1">
				<thead>
					<tr>
						<th></th>
						<th>글번호</th>
						<th>작성자(ID)</th>
						<th>제목</th>
						<th>작성일</th>
						<th>수정일</th>
						<th>조회수</th>
					</tr>
				</thead>
				<tbody>		
					
				</tbody>
			</table>

		</div>
		<div class="d-flex justify-content-center">
		    <ul class="pagination">
		       
		        <li class='page-item ${pageInfo.pageIndex == 1 ? "disabled" : ""}'>
		            <a class="page-link" onclick="nav(1); return false;">&laquo;</a>
		        </li>
		        
		        
		        <li class='page-item ${pageInfo.pageIndex <= 5 ? "disabled" : ""}'>
		            <a class="page-link" onclick="nav(${pageInfo.pageIndex - 5}); return false;">이전</a>
		        </li>
		        
		        
		        <c:forEach var="num" begin="${pageInfo.getBlockStartPage()}" end="${pageInfo.getBlockEndPage()}" step="1">
		            <li class='page-item ${pageInfo.pageIndex == num ? "active" : ""}'>
		                <a class="page-link" onclick="nav(${num}); return false;">${num}</a>
		            </li>
		        </c:forEach>
		       
		        
		        <li class='page-item ${pageInfo.pageIndex + 5 >= pageInfo.totalPages ? "disabled" : ""}'>
		            <a class="page-link" onclick="nav(${pageInfo.pageIndex + 5}); return false;">다음</a>
		        </li>
		        
		        
		        <li class='page-item ${pageInfo.pageIndex >= pageInfo.totalPages ? "disabled" : ""}'>
		            <a class="page-link" onclick="nav(${pageInfo.totalPages}); return false;">&raquo;</a>
		        </li>
		    </ul>
		</div>

	</div>
	<div id="boardInsert" style="display: none;">
		<div class="container-fluid d-flex justify-content-center align-items-center vh-100">
			<div class="card p-4" style="max-width: 500px; width: 100%;">
				<form action="/insert" method="post">
					<div class="mb-3">
						<label for="memName" class="form-label">작성자</label> <input
							type="text" class="form-control" id="memName">
					</div>
					<div class="mb-3">
						<label for="memId" class="form-label">ID</label> <input
							type="text" class="form-control" id="memId" >
					</div>
					<div class="mb-3">
						<label for="boardSubject" class="form-label">제목</label> <input
							type="text" class="form-control" id="boardSubject"
							>
					</div>
					<div class="mb-3">
						<label for="boardContent" class="form-label">내용</label>
						<textarea class="form-control" id="boardContent"
							 rows="4"></textarea>
					</div>
				
					<div class="text-end">
						<button class="btn btn-primary" onclick="insertBoard()">등록하기</button>
						<button class="btn btn-danger" onclick="backList()">이전</button>
					</div>
				</form>
			</div>
		</div>
	</div>

	<div id="boardUpdate" style="display: none;">
		<div
			class="container-fluid d-flex justify-content-center align-items-center vh-100">
			<div class="card p-4" style="max-width: 500px; width: 100%;">
				<div class="mb-3">
					<h1>게시글 수정</h1>
				</div>
				<form action="/update" method="post">
					<div class="mb-3">
						<label for="boardSubject" class="form-label">제목</label> <input
							type="text" class="form-control" id="boardSubject"
							name="boardSubject">
					</div>
					<div class="mb-3">
						<label for="writer" class="form-label">작성자</label> <input
							type="text" class="form-control" id="writer"
							name="memId">
					</div>
					<div class="mb-3">
						<label for="content" class="form-label">내용</label>
						<textarea class="form-control" id="content" style="width: 100%;"
							rows="8" name="boardContent"></textarea>
					</div>
					<div class="mb-3">
						
						<label for="regDate" class="form-label">작성일</label> <input
							type="text" class="form-control" id="regDate"
							 readonly>

					</div>
					<div class="mb-3 text-center">
						<div class="box d-inline-block"></div>
					</div>
					<div style="display: none;">
						<input name="seq" id="seq">
					</div>


					<div class="text-end">
						<button type="submit" class="btn btn-primary">수정완료</button>
						<a href="#" onclick="deleteBoard($('#boardUpdate #seq').val())"
							class="btn btn-danger">삭제</a> 
						<a href="/list"	class="btn btn-info">리스트로</a>
					</div>
				</form>

			</div>

		</div>
	</div>
	<div id="boardRead" style="display: none;">
		<div class="container-fluid d-flex justify-content-center align-items-center vh-100">
			<div class="card p-4" style="max-width: 500px; width: 100%;">
			<div class="mb-3">
				<h1>게시글 상세보기</h1>
			</div>
			<div class="mb-3">
				<label for="boardSubject" class="form-label">제목</label> <input
					type="text" class="form-control" id="boardSubject" readonly>
			</div>
			<div class="mb-3">
				<label for="writer" class="form-label">작성자</label> <input type="text"
					class="form-control" id="writer" readonly>
			</div>
			<div class="mb-3">
				<label for="content" class="form-label">내용</label>
				<textarea class="form-control" id="content" style="width: 100%;"
					rows="8" readonly></textarea>
			</div>
			<div class="mb-3">
				<label for="regDate" class="form-label">작성일</label> <input
					type="text" class="form-control" id="regDate" readonly>
	
			</div>
			<div class="mb-3 text-center">
				<div class="box d-inline-block"></div>
			</div>
			<div style="display: none;">
				<input type="text" id="seq">
			</div>
			<div class="text-end">
				<a onclick="changeUpdate($('#boardRead #seq').val())">
					<button class="btn btn-primary">수정</button>
				</a>
				<a onclick="backList()">
					<button class="btn">뒤로가기</button>
				</a>
	
			</div>
		</div>
		</div>
		
	</div>
	
	<script>

		function changeInsert() {
		     $('#boardInsert').css('display', 'block');
		     $('#boardList').css('display', 'none');
		}
		function changeRead(seq){
			
		    $.ajax({
		        url: '/read/' + seq,
		        method: 'GET',
		        success: function(data) {
		            // 서버에서 가져온 데이터를 HTML에 삽입
		            $('#boardRead #seq').val(data.seq);
		            $('#boardRead #boardSubject').val(data.boardSubject);
		            $('#boardRead #writer').val(data.memId);
		            $('#boardRead #content').val(data.boardContent);
		            $('#boardRead #regDate').val(new Date(data.regDate).toISOString().slice(0, 10));
		            $('#boardRead .box').text("👀 " + data.viewCnt);

		            // 리스트와 입력폼 숨기고 읽기 폼 표시
		            $('#boardList').css('display', 'none');
		            $('#boardInsert').css('display', 'none');
		            $('#boardRead').css('display', 'block');
		            $('#boardUpdate').css('display', 'none');
		        },
		        error: function(err) {
		            alert('게시물을 불러오는데 실패했습니다.');
		        }
		    });
			
		}
		function backList(){
			 $('#boardInsert').css('display', 'none');
		     $('#boardList').css('display', 'block');
		     $('#boardRead').css('display', 'none');
		     $('#boardUpdate').css('display', 'none');
		}
		
		function insertBoard(){
			event.preventDefault();
			
			memName =  $('#boardInsert #memName').val();
			memId = $('#boardInsert #memId').val();
			boardSubject = $('#boardInsert #boardSubject').val();
			boardContent = $('#boardInsert #boardContent').val();
			
			var confirmed = this.confirm(memName+"의 글을 등록하시겠습니까")
			
			if(confirmed){
				$.ajax({
				    url: '/insert',  
				    type: "POST",                         // POST 요청
				    contentType: "application/json",      // JSON 데이터 전송
				    data: JSON.stringify({
				    	 memName: memName,                                    
				         memId: memId,                                
				         boardSubject: boardSubject,                         
				         boardContent: boardContent 
				    }),
				    success: function(response) {
				        console.log("게시물 등록 성공:", response);
				        window.location.href = '/list';
				    },
				    error: function(xhr, status, error) {
				        console.error("게시물 등록 실패:", error);
				        return;
				    }
				});
				
			}
			
			
			
		}
		
		function changeUpdate(seq){
			
			$.ajax({
		        url: '/update/' + seq,
		        method: 'GET',
		        cache: false,
		        success: function(data) {
		            // 서버에서 가져온 데이터를 HTML에 삽입
		            $('#boardUpdate #seq').val(data.seq);
		            $('#boardUpdate #boardSubject').val(data.boardSubject);
		            $('#boardUpdate #writer').val(data.memId);
		            $('#boardUpdate #content').val(data.boardContent);
		            $('#boardUpdate #regDate').val(new Date(data.regDate).toISOString().slice(0, 10));
		            $('#boardUpdate .box').text("👀 " + data.viewCnt);

		            // 리스트와 입력폼 숨기고 읽기 폼 표시
		            $('#boardList').css('display', 'none');
		            $('#boardInsert').css('display', 'none');
		            $('#boardRead').css('display', 'none');
		            $('#boardUpdate').css('display', 'block');
		        },
		        error: function(err) {
		        	console.error('Request failed with status: ' + status);
		            console.error('Error: ' + error);
		            console.error('Response: ' + xhr.responseText);
		            alert('게시물을 불러오는데 실패했습니다. 콘솔을 확인하세요.');
		        }
		    });
		}
		function deleteBoard(seq){
			$.ajax({
		        url: '/delete/' + seq,
		        method: 'POST',
		        cache: false,
		        success: function() {
		            alert("삭제 완료");
		            window.location.href = '/list';
		        },
		        error: function(err) {
		        	console.error('Request failed with status: ' + status);
		            console.error('Error: ' + error);
		            console.error('Response: ' + xhr.responseText);
		            alert('삭제 실패.');
		        }
		    });
		}
		function deleteBoards(){
			var selectedValues = [];
		    $('input.seq:checked').each(function() {
		        selectedValues.push($(this).val());
		    });

		    if (selectedValues.length === 0) {
		        alert('삭제할 항목을 선택하세요.');
		        return;
		    }
			var confirmed = this.confirm("삭제하시겠습니까")
			
			if(confirmed){
				// 선택된 항목의 seq를 서버로 전송하여 삭제
			    $.ajax({
			        url: '/deletelist',
			        method: 'POST',
			        contentType: 'application/json',
			        data: JSON.stringify(selectedValues),
			        success: function() {
			            alert("선택된 항목이 삭제되었습니다.");
			            // 삭제 후 페이지를 새로고침하거나 /list로 이동
			            window.location.href = '/list';
			        },
			        error: function(xhr, status, error) {
			            console.error('Request failed with status: ' + status);
			            console.error('Error: ' + error);
			            console.error('Response: ' + xhr.responseText);
			            alert('삭제 실패.');
			        }
			    });
			}
		    
		}
		
	</script>
</body>
</html>