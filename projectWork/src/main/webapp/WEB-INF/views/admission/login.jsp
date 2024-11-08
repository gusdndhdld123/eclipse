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
<title>login</title>

</head>
<body>
	 <div class="contaioner" >
            <h1>
                Login
            </h1>
            <div>
            <form method="post" action="/admission/login">
                <div>
                    <table>
                        <tr>
                            <td>
                                아이디 :
                            </td>
                            <td>
                                <input type="text" id="userId" name="userId">
                            </td>
                        </tr>
                        <tr>
                            <td>
                                비밀번호 :
                            </td>
                            <td>
                                <input type="text" id="userPw" name="userPw">
                            </td>
                        </tr>
                        
                    </table>
                </div>
                <button type="submit" style="display: flex;">로그인</button>
            </div>
        </form>
        </div>
        
</body>
<script>
	<% if (request.getAttribute("errorMessage") != null) { %>
	alert("<%= request.getAttribute("errorMessage") %>");
	<% } %>
</script>
</html>