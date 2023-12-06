<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.*" %>
<%@ page import="java.net.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page language="java" import="java.text.*,java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<style>

@import url("https://fonts.googleapis.com/css2?family=Nanum+Myeongjo&display=swap");
@import url("https://fonts.googleapis.com/css?family=Open+Sans:400,400i,700");


body {
    background-color: lightblue;
    font-family: 'Nanum Myeongjo', serif;
    text-align: center;
    color: #FFFFFF;
}
h1 {
    color: white;
    text-align: center;
    
}
p {
    font-family: verdana;
    font-size: 20px;
}

h1 {
  position: relative;
  padding: 0;
  margin: 0;
  font-family: "Raleway", sans-serif;
  font-weight: 300;
  font-size: 40px;
  color: #FFFFFF;
  -webkit-transition: all 0.4s ease 0s;
  -o-transition: all 0.4s ease 0s;
  transition: all 0.4s ease 0s;
}

.title h1 {
  text-align: center;
  text-transform: uppercase;
  padding-bottom: 5px;
}
.title h1:before {
  width: 28px;
  height: 5px;
  display: block;
  content: "";
  position: absolute;
  bottom: 3px;
  left: 50%;
  margin-left: -14px;
  background-color: #b80000;
}
.title h1:after {
  width: 100px;
  height: 1px;
  display: block;
  content: "";
  position: relative;
  margin-top: 25px;
  left: 50%;
  margin-left: -50px;
  background-color: #b80000;
}
span {
color: #FFFFFF;
}
label {
color: #FFFFFF;
}


.login-box .user-box {
  position: relative;
  width: 60%;
  left: 20%;
}

.login-box .user-box input {
  width: 100%;
  padding: 10px 0;
  font-size: 16px;
  color: #fff;
  margin-bottom: 30px;
  border: none;
  border-bottom: 1px solid #fff;
  outline: none;
  background: transparent;
}
.login-box .user-box label {
  position: absolute;
  top:0;
  left: 0;
  padding: 10px 0;
  font-size: 16px;
  color: #fff;
  pointer-events: none;
  transition: .5s;
}

.login-box .user-box input:focus ~ label,
.login-box .user-box input:valid ~ label {
  top: -20px;
  left: 0;
  color: #03e9f4;
  font-size: 12px;
}

input[type=submit] {
    
    width: 70%;
    background-color: #4CAF50;
    color: white;
    padding: 14px 20px;
    
    border: none;
    border-radius: 4px;
    cursor: pointer;
}


</style>
<meta charset="UTF-8">
<title>RECRUIT: KNU</title>
</head>
<body>



<%
    if (request.getMethod().equalsIgnoreCase("post")) {
        String userInput = request.getParameter("DBuser");
        String javaVariable = userInput;
        out.println("Java 변수 값: " + javaVariable);
    }
%>

    <div class="title"><h1>RECRUIT: KNU</h1></div>

<br />
<br />
<br />
<br />
<span>
데이터베이스의 사용자 이름과 비밀번호를 입력하십시오.
인증을 위해 직원 ID와 성명을 입력하여 주십시오.
</span>

<br />
<br />
<br />
<div class="login-box">
    <form action="login.jsp" method="post" accept-charset="utf-8">
     	<label for="DBuser">데이터베이스 사용자 ID</label>
     	<div class="user-box">
     	
    	<input type="text" name="DBuser"><br><br>
    	</div>
    	
    	<label for="DBpass">데이터베이스 비밀번호</label>
    	     	<div class="user-box">
    	
    	<input type="password" name="DBpass"><br><br>
     </div>
    
        <label for="id">ID:</label>
             	<div class="user-box">
        
        <input type="text" id="id" name="id"><br><br>
        </div>
        <label for="name">이름:</label>
             	<div class="user-box">
        
        <input type="text" id="name" name="name"><br><br>
        </div>
        <input type="submit" class="big-button" value="로그인">
    </form>

</div>

<br />
<br />
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
</body>
</html>