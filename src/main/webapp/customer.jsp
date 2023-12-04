<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
고객 관리 화면
<br />
고객 추가
<br />
    <form action="addcustomer.jsp" method="post" accept-charset="utf-8">
        <label for="fname">성: </label>
        <input type="text" id=fname" name="fname"><br><br>
        
        <label for="lname">이름:</label>
        <input type="text" id="lname" name="lname"><br><br>
        
        <label for="gender">성별:</label>
        <input type="text" id="gender" name="gender"><br><br>
        
        <label for="email">이메일 주소:</label>
        <input type="text" id="email" name="email"><br><br>
        
        <label for="id">ID:</label>
        <input type="text" id="id" name="id"><br><br>
        
        <label for="password">비밀번호:</label>
        <input type="text" id="password" name="password"><br><br>
        
        <label for="phone">전화번호:</label>
        <input type="text" id="phone" name="phone"><br><br>
        
        <label for="birth">생년월일:</label>
        <input type="text" id="birth" name="birth"><br><br>
        
        <input type="submit" value="Submit">
    </form>
<br />
고객 정보 검색(ID를 입력하여 주십시오.)
<br />
	<form>
        <label for="c_id">ID: </label>
        <input type="text" id=c_id" name="c_id"><br><br>
	</form>
	        <input type="submit" value="Submit">
	
<br />
고객 정보 삭제(ID를 입력하여 주십시오.)
<br />
<br />
	<form>
        <label for="del_id">삭제할 ID: </label>
        <input type="text" id=del_id" name="del_id"><br><br>
	</form>
	        <input type="submit" value="Submit">
	
<br />


</body>
</html>