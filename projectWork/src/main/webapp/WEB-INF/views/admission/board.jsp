<%@ page session="true" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<html>
<head>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
    <script src="https://code.jquery.com/jquery-latest.min.js"></script>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>board</title>
</head>
<body>
    <div class="container" style="display : flex">
        <h1>반갑습니다. ${user.userName} 님	</h1>
        <a href="/logout"><button class="btn btn-danger">로그아웃</button></a> 
    </div>
    <div>
    	<a href="/admission/write">
    		<button>글쓰기</button>
    	</a>
    </div>
    <div>
    </div>
    <div style="width : 80% justify-center">
	  	<table class="table table-striped">
	  		<th>
	  			<tr>
	  				<td>번호</td>
	  				<td>작성자</td>
	  				<td>제목</td>
	  				<td>작성일</td>
	  				<td>결재일</td>
	  				<td>결재자</td>
	  				<td>결재상태</td>
	  			</tr>
	  		</th>
	  		<tbody>
	  			<tr>
	  				<td>번호</td>
	  				<td>작성자</td>
	  				<td>제목</td>
	  				<td>작성일</td>
	  				<td>결재일</td>
	  				<td>결재자</td>
	  				<td>결재상태</td>
	  			</tr>
	  		</tbody>
		</table>
    </div>
</body>
</html>
