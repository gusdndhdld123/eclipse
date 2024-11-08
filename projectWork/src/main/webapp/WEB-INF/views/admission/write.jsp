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
<title>wirte</title>

</head>
<body>
	 <div class="contaioner" >
            <h1>
                Write
            </h1>
            <div>
            <form method="post" action="/admission/write">
                <div>
                    <table>
                        <tr>
                            <td>
                                	제목 :
                            </td>
                            <td>
                                <input type="text" id="admDTO.title" name="admDTO.title">
                            </td>
                        </tr>
                        <tr>
                            <td>
                                	작성자 :
                            </td>
                            <td>
                                ${user.userName}
                            </td>
                        </tr>
                        <tr>
                            <td>
                                	내용 :
                            </td>
                            <td>
                                <textarea id="admDTO.content" name="admDTO.content"></textarea>
                            </td>
                        </tr>
                    </table>
                </div>
                <button type="submit" style="display: flex;">글작성</button>
            </div>
        </form>
        </div>
        
</body>
<script>
	
</script>
</html>