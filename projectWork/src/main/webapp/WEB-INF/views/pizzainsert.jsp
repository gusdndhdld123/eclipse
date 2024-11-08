<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
	language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>

<html>
<head>
<title>pizzaInsert</title>
</head>
<body>
	<div>
		<h1>피자메뉴 추가</h1>
        <form method="post" action="/pizzainsert" >

		<table>
			<tr>
				<td>메뉴명 :</td>
                <td><input name="menuName"></td>
			</tr>
			<tr>
				<td>서브타이틀 :</td>
                <td><input name="subTitle"></td>
			</tr>
            <tr>
				<td>메뉴타입 :</td>
                <td>
                    <select name="menuType">
                        <option value="S">시그니처</option>
                        <option value="P">프리미엄</option>
                        <option value="C">클래식</option>
                        <option value="1">1인용</option>
                        <option value="B">보너스파우치</option>
                        <option value="X">샐러드&사이드</option>
                        <option value="Y">파스타&라이스</option>	
                        <option value="Z">음료</option>
                        <option value="O">기타</option>
                    </select>
                </td>
			</tr>
            <tr>
				<td>이미지1 :</td>
                <td><input name="menuImg1"></td>
			</tr>
            <tr>
				<td>이미지2 :</td>
                <td><input name="menuImg2"></td>
			</tr>
            <tr>
				<td>
                    이미지3 :</td>
                <td><input name="menuImg3"></td>
			</tr>
            <tr>
				<td>메뉴사이즈 S의 가격 :</td>
                <td><input name="menuPriceS"></td>
			</tr>
            <tr>
				<td>메뉴사이즈 M의 가격 :</td>
                <td><input name="menuPriceM"></td>
			</tr>
			<tr>
				<td>메뉴사이즈 L의 가격 :</td>
                <td><input name="menuPriceL"></td>
			</tr>
            <tr>
				<td>메뉴설명 :</td>
                <td>
                    <textarea name="menuDiscription"></textarea>
                </td>
			</tr>
            <tr>
				<td>
                    메뉴설명이미지 :</td>
                <td><input name="detailImg"></td>
			</tr>
            <tr>
				<td>도우 :</td>
                <td><input name="menuDough"></td>
			</tr>
            <tr>
				<td>엣지 :</td>
                <td>
                	<label for="edge4">없음</label>
                    <input type="checkbox" id="edge4" name="menuEdge" value="">
                    <label for="edge1">골드</label>
                    <input type="checkbox" id="edge1" name="menuEdge" value="골드">
                    <label for="edge2">크림치즈</label>
                    <input type="checkbox" id="edge2" name="menuEdge" value="크림치즈">
                    <label for="edge3">오리진</label>
                    <input type="checkbox" id="edge3" name="menuEdge" value="오리진">
                    <label for="edge3">치즈캡</label>
                    <input type="checkbox" id="edge3" name="menuEdge" value="치즈캡">
                    <label for="edge3">에그타르트</label>
                    <input type="checkbox" id="edge3" name="menuEdge" value="에그타르트">
                </td>
			</tr>
            <tr>
				<td>세트메뉴여부 :</td>
                <td>
                    <select name="menuSet">
                        <option value="Y">Y</option>
                        <option value="N" default>N</option>
                    </select>
                </td>
			</tr>
            <tr>
				<td>사이드메뉴여부 :</td>
                <td>
                    <select name="menuSide">
                        <option value="Y">Y</option>
                        <option value="N" default>N</option>
                    </select>
                </td>
			</tr>
            
		</table>
        <button type="submit">입력</button>
        </form>
	</div>
	
</body>
</html>