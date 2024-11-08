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
<title>BoardList</title>

</head>
<script>
	$(document).ready(function() {
	    $('#searchType').val('${map.searchType}');
	    $('#pageIndex').val('1');
	
	    $('#searchbtn').on('click', function() {
	        var searchType = $('#searchType').val();
	        var startDate = $('#startDate').val(); 
	        var endDate = $('#endDate').val();
			var keyword = $('#keyword').val();
	        if (searchType === "") {
	            alert("검색 조건을 선택하세요");
	            return;
	        }
			if ((keyword === "")|| (keyword === null)){
				 alert("검색어를 입력하세요");
		         return;
			}
				
	        if ((startDate === "" && endDate !== "") || (startDate !== "" && endDate === "")) {
	            if (startDate === "") {
	                alert("시작 날짜를 지정해주세요");
	                return;
	            } else {
	                alert("끝 날짜를 지정해주세요");
	                return;
	            }
	          
	        }
	
	        // 모든 조건이 충족되면 폼 제출
	        $('#searchForm').attr('action', '/list');
	        $('#searchForm').attr('method', 'post');
	        $('#searchForm').submit();
	    });
	});
	
	function getExcel(){
		
	    var searchType = $('#searchType').val();
        var startDate = $('#startDate').val(); 
        var endDate = $('#endDate').val();
		var keyword = $('#keyword').val();
        if (searchType === "") {
            alert("검색 조건을 선택하세요");
            return;
        }
		if ((keyword === "")|| (keyword === null)){
			 alert("검색어를 입력하세요");
	         return;
		}
			
        if ((startDate === "" && endDate !== "") || (startDate !== "" && endDate === "")) {
            if (startDate === "") {
                alert("시작 날짜를 지정해주세요");
                return;
            } else {
                alert("끝 날짜를 지정해주세요");
                return;
            }
          
        }

        // 모든 조건이 충족되면 폼 제출
        $('#searchForm').attr('action', '/excel');
        $('#searchForm').attr('method', 'get');
        $('#searchForm').submit();
	}
	
	function nav(num) {
	    
	    $('#pageIndex').val(num); 
	    $('#searchForm').attr('action', '/list'); 
	    $('#searchForm').attr('method', 'post'); 
	    $('#searchForm').submit(); 
	}
</script>
<body>
	<div id="boardList">
		<div class="container-fluid" style="text-aline: center;">
			<div style="padding: 1%;">
				<a href="/list">
					<h1>BoardList</h1>
				</a>
			</div>
			<div style="width : 100%;">
				<form class="search-form"
					style="width: 100%; padding-left: 10%;" autocomplete="off" id="searchForm">
					<div style="display:none">
						<input type="text" name="pageIndex" value="${pageInfo.pageIndex}" id="pageIndex">
						<input type="text" value="10" name="pageSize">
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
				<button class="btn btn-info" onclick="getExcel()">엑셀</button>
			</div>
			<table class="table" border="1">
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
					<c:forEach items="${boardList}" var="board">
						<tr>
							<td><input type="checkbox" class="seq" value="${board.seq}"></td>
							<td>${board.seq}</td>
							<td>${board.memId}</td>
							<td >
							<a onclick="changeRead(${board.seq})" style="color:blue; cursor:pointer;">${board.boardSubject}</a>
							</td>
							<fmt:formatDate value="${board.regDate}" pattern="yyyy-MM-dd"
								var="formattedRegDate" />
							<td>${formattedRegDate}</td>
							<fmt:formatDate value="${board.uptDate}" pattern="yyyy-MM-dd"
								var="formattedUptDate" />
							<td>${formattedUptDate}</td>
							<td>${board.viewCnt}</td>
						</tr>
					</c:forEach>
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
				<form action="/insert" method="post" enctype="multipart/form-data">
					<div class="mb-3">
						<label for="memName" class="form-label">작성자</label> <input
							type="text" class="form-control" id="memName" name="memName">
					</div>
					<div class="mb-3">
						<label for="memId" class="form-label">ID</label> <input
							type="text" class="form-control" id="memId" name="memId">
					</div>
					<div class="mb-3">
						<label for="boardSubject" class="form-label">제목</label> <input
							type="text" class="form-control" id="boardSubject" name="boardSubject"
							>
					</div>
					<div class="mb-3" id="fileDiv">
						<input type="button" class="btn btn-success" onclick="inputplus()" value="사진추가" style="margin-bottom:15px;"></button><br>
						
					</div>
																		
					<div class="mb-3">
						<label for="boardContent" class="form-label">내용</label>
						<textarea class="form-control" id="boardContent"
							 rows="4" name="boardContent"></textarea>
					</div>
					
					<div class="text-end">
						<button class="btn btn-primary" type="submit">등록하기</button>
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
			<div>
				<p>첨부파일</p>
			</div>
			<div class="mb-3" id="imageContainer">
			
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
		var uploadList = [];
		
		
		function changeInsert() {
			event.preventDefault();
		     $('#boardInsert').css('display', 'block');
		     $('#boardList').css('display', 'none');
		}
		
		function changeRead(seq) {
		    $.ajax({
		        url: '/read/' + seq,
		        method: 'GET',
		        success: function(data) {
		            // 서버에서 가져온 데이터를 HTML에 삽입
		            $('#boardRead #seq').val(data.boardDTO.seq);
		            $('#boardRead #boardSubject').val(data.boardDTO.boardSubject);
		            $('#boardRead #writer').val(data.boardDTO.memId);
		            $('#boardRead #content').val(data.boardDTO.boardContent);
		            $('#boardRead #regDate').val(new Date(data.boardDTO.regDate).toISOString().slice(0, 10));
		            $('#boardRead .box').text("👀 " + data.boardDTO.viewCnt);
		            
		            // 이미지 표시
		            const imageContainer = $('#imageContainer');
		            imageContainer.empty(); // 기존 이미지를 초기화
		            
		            if (data.uploadDTOList && data.uploadDTOList.length > 0) {
		                for (let i = 0; i < data.uploadDTOList.length; i++) {
		                    const upload = data.uploadDTOList[i];
		                    const realName = upload.realName; 
		                    const fileSeq = upload.fileSeq; 
		                    const savePath = upload.savePath;
		                    const linkElement = 
		                    	 '<img alt="'+realName+'" src="/image/' + fileSeq + '" style="max-width:100px;"/><br>' +
		                         '<a href="/download/' + fileSeq + '">' + realName + '</a><br>'; // 링크 생성
		                    
		                    imageContainer.append(linkElement);
		                }
		            }


		            
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
				event.preventDefault();
			 $('#boardInsert').css('display', 'none');
		     $('#boardList').css('display', 'block');
		     $('#boardRead').css('display', 'none');
		     $('#boardUpdate').css('display', 'none');
		}
		
		function insertBoard() {
		    event.preventDefault();

		    var memName = $('#memName').val();
		    var memId = $('#memId').val();
		    var boardSubject = $('#boardSubject').val();
		    var boardContent = $('#boardContent').val();

		    var confirmed = confirm(memName + "의 글을 등록하시겠습니까");
		    if (confirmed) {
		        var formData = new FormData();

		        // boardDTO를 JSON으로 변환하여 추가
		        var boardDTO = {
		            memName: memName,
		            memId: memId,
		            boardSubject: boardSubject,
		            boardContent: boardContent
		        };
		        formData.append("boardDTO", new Blob([JSON.stringify(boardDTO)], { type: "application/json" }));

		        // 파일 개별적으로 추가
		        for (var i = 0; i < uploadList.length; i++) {
		            formData.append("files", uploadList[i]); // 파일 개별 추가
		        }

		        console.log(uploadList, "uploadList 내용");

		        $.ajax({
		            url: '/insert',
		            type: "POST",
		            data: formData,
		            processData: false,
		            contentType: false,
		            success: function(response) {
		                console.log("게시물 등록 성공:", response);
		                window.location.href = '/list';
		            },
		            error: function(xhr, status, error) {
		                console.error("게시물 등록 실패:", error);
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
		$(document).ready(function() {
		    $('#uploadDTO').on('change', function() {
		    	const files = $(this)[0].files;
		        const tableBody = $('#fileTable tbody');

		        for (let i = 0; i < files.length; i++) {
		            const fileName = files[i].name;
		            uploadList.push(files[i]); // 파일을 리스트에 추가
					console.log(uploadList, "uploadList내용");
		            const row = 
		                '<tr>' +
		                    '<td>' + fileName + '</td>' +
		                    '<td><button class="btn btn-danger delete-btn">삭제</button></td>' +
		                '</tr>';

		            tableBody.append(row); 
		        }
		    });

		    // 삭제 버튼 클릭 시 해당 행 제거
		    $('#fileTable').on('click', '.delete-btn', function() {
		        const row = $(this).closest('tr');
		        const fileName = row.find('td:first').text(); // 파일 이름 가져오기
		        row.remove(); // 행 제거
		        
		        // 리스트에서 해당 파일 이름 제거
		        const index = uploadList.findIndex(file => file.name === fileName); 
		        if (index > -1) {
		            uploadList.splice(index, 1);
		        }
		    });
		});

		
		$('#uploadDTO').on('change', function(event) {
		    const files = event.target.files;
		    let valid = true;

		    $.each(files, function(index, file) {
		        const img = new Image();
		        img.onload = function() {
		            if (this.width > 500 || this.height > 500) {
		                alert('이미지 크기는 500x500 픽셀을 넘을 수 없습니다.');
		                valid = false;
		                $('#uploadDTO').val(''); // 파일 선택 초기화
		            }
		        };
		        img.src = URL.createObjectURL(file);
		    });
		});
		var tmp = 0;
		function inputplus(){
			
			var filehtml = "<input type=file id=file"+tmp+" name=file onchange=filecheck(this)><button id=delBtn"+tmp+" onclick=deleteinput(this) >삭제</button><br>"

			$('#fileDiv').append(filehtml)
			
			tmp ++
		}
		function deleteinput(delBtn){
			event.preventDefault();
			$(delBtn).prev().remove();
			$(delBtn).next().remove();
			$(delBtn).remove();
		}
		
		function filecheck(filecheck) {
		    var file = filecheck.files[0];
		    var _URL = window.URL || window.webkitURL;
		    var img = new Image();
		    var maxwidth = 500;
		    var maxheight = 500;

		    if (filecheck.value != "") {
		        var ext = filecheck.value.split('.').pop().toLowerCase();

		        // 허용된 확장자 목록 확인
		        if ($.inArray(ext, ['jpg', 'jpeg', 'bmp', 'gif']) == -1) {
		            alert("이미지만 업로드 가능합니다.");
		            filecheck.value = "";  // 파일 선택 초기화
		            return;
		        }
		    }

		    // 파일의 URL을 생성 후 이미지 로딩
		    img.src = _URL.createObjectURL(file);

		    img.onload = function() {
		        // 이미지 크기 체크 (이미지 로딩 완료 후)
		        if (img.width > maxwidth || img.height > maxheight) {
		            alert("사진 크기가 너무 큽니다. 500 x 500 미만 크기의 사진만 업로드 할 수 있습니다.");
		            filecheck.value = "";  // 파일 선택 초기화
		            return;
		        }
		    };

		    img.onerror = function() {
		        // 이미지가 로드되지 않는 경우 에러 처리
		        alert("유효하지 않은 이미지 파일입니다.");
		        filecheck.value = "";  // 파일 선택 초기화
		    };
		}


	</script>
</body>
</html>