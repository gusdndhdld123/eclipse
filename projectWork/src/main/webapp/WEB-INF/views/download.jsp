
<%@ page session="false"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
	language="java"%>
<%
    response.setHeader("Content-Disposition","attachment;filename=board.xls");    //디폴트 파일명 지정
    response.setHeader("Content-Description", "JSP Generated Data"); 
%>
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

</body>
</html>