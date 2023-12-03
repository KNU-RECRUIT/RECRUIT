<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page language="java" import="java.text.*,java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	String serverIP = "localhost";
	String strSID = "xe";
	String portNum = "1521";
	String user = "university";
	String pass = "comp322";
	String url = "jdbc:oracle:thin:@"+serverIP+":"+portNum+":"+strSID;
	

	Connection conn = null;
	PreparedStatement pstmt;
	ResultSet rs;
	Class.forName("oracle.jdbc.driver.OracleDriver");
	try{
	conn = DriverManager.getConnection(url, user, pass);
	}
	catch(SQLException e){
		out.println("연결 실패");
		out.println("네트워크 연결 상태 또는 Driver 상태를 점검하여 주십시오. ");
	}
	
	
%>
<h1>
	RECRUIT: KNU
</h1>
인증을 위해 ID와 이름을 입력하여 주십시오.

    <form action="login.jsp" method="post" accept-charset="utf-8">
        <label for="id">ID:</label>
        <input type="text" id="id" name="id"><br><br>
        
        <label for="name">이름:</label>
        <input type="text" id="name" name="name"><br><br>
        
        <input type="submit" value="Submit">
    </form>

</body>
</html>