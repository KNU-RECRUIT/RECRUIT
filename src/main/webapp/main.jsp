<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.*" %>
<%@ page import="java.net.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page language="java" import="java.text.*,java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	String strSID = "";
    String OS = System.getProperty("os.name").toLowerCase();
    if (OS.contains("win")) {
    	strSID = "orcl";
    	out.println("관리자 시스템 실행 정보 OS: Windows");
    } else if (OS.contains("mac") || OS.contains("nix") || OS.contains("nux") || OS.contains("sunos")) {
    	
    	strSID = "xe";
    	out.println("관리자 시스템 실행 정보 OS: macOS/UNIX/Linux");

    } else {
        out.println("Wrong OS!<br />");
    }

%>


<%
    if (request.getMethod().equalsIgnoreCase("post")) {
        String userInput = request.getParameter("DBuser");
        String javaVariable = userInput;
        out.println("Java 변수 값: " + javaVariable);
    }
%>
<h1>
	RECRUIT: KNU
</h1>

데이터베이스의 사용자 이름과 비밀번호를 입력하십시오.
인증을 위해 직원 ID와 성명을 입력하여 주십시오.

    <form action="login.jsp" method="post" accept-charset="utf-8">
     	<label for="DBuser">데이터베이스 사용자 ID:</label>
    
    	<input type="text" name="DBuser"><br><br>
    	
    	<label for="DBpass">데이터베이스 비밀번호</label>
    	
    	<input type="password" name="DBpass"><br><br>
     
    
        <label for="id">ID:</label>
        <input type="text" id="id" name="id"><br><br>
        
        <label for="name">이름:</label>
        <input type="text" id="name" name="name"><br><br>
        
        <input type="submit" value="Submit">
    </form>



</body>
</html>