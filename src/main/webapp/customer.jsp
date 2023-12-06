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
body {
    background-color: lightblue;
}

h1 {
    color: white;
    text-align: center;
}

p {
    font-family: verdana;
    font-size: 20px;
}

a {
    font-family: verdana;
    font-size: 20px;
}

label {
    font-family: verdana;
    font-size: 20px;
}

input[type=text], select {
    width: 100%;
    padding: 12px 20px;
    margin: 8px 0;
    
    border: 1px solid #ccc;
    border-radius: 4px;
    box-sizing: border-box;
}

input[type=submit] {
    
    width: 100%;
    background-color: #4CAF50;
    color: white;
    padding: 14px 20px;
    
    border: none;
    border-radius: 4px;
    cursor: pointer;
}

table {
  border-collapse: collapse;
  width: 100%;
}

table td, table th {
  border: 1px solid #ddd;
  padding: 8px;
}

table tr:nth-child(even){background-color: #f2f2f2;}

table tr:hover {background-color: #ddd;}

table th {
  padding-top: 12px;
  padding-bottom: 12px;
  text-align: left;
  background-color: #04AA6D;
  color: white;
}
</style>
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
	<form action="customer.jsp" method="post" accept-charset="utf-8">
        <label for="c_id">ID: </label>
        <input type="text" id=c_id" name="c_id"><br><br>
		<input type="hidden" name="formIdentifier" value="s_form">
		<input type="submit" value="Submit">
	</form>
	
	
<%
	String strSID = "";
    String OS = System.getProperty("os.name").toLowerCase();
    if (OS.contains("win")) {
    	strSID = "orcl";
    } else if (OS.contains("mac") || OS.contains("nix") || OS.contains("nux") || OS.contains("sunos")) {
    	
    	strSID = "xe";

    } else {
        out.println("OS 정보가 올바르지 않거나 인식되지 않습니다. UNIX/Linux/macOS/Windows외의 OS 사용 시 본 사이트와 호환되지 않을 수 있습니다.<br />");
    }

    	try
    	{
        String login_user_id = session.getAttribute("recruit_id").toString();
    	String login_user_name = session.getAttribute("recruit_name").toString();
    	}
    	catch(NullPointerException e)
    	{
    		out.println("<script>");
    		out.println("alert('로그인 정보(권한)이 없습니다. 정상적인 경로로 다시 접속하여 주시기 바랍니다.');");
    		out.println("location.href='main.jsp';");
    		out.println("</script>");

    	}
    
   
/* 	if(login_user_id==null || login_user_name==null || login_user_id.equals("") || login_user_name.equals(""))
	{

		
	} */

/* 	 */
    
    
%>
<%
//폼 데이터가 전송되었을 때 처리
	request.setCharacterEncoding("UTF-8");
	String serverIP = "localhost";
	String portNum = "1521";
	String user = "university";
	String pass = "comp322";
	String url = "jdbc:oracle:thin:@"+serverIP+":"+portNum+":"+strSID;
	

	Connection conn = null;
	PreparedStatement pstmt;
	Class.forName("oracle.jdbc.driver.OracleDriver");
	try{
	conn = DriverManager.getConnection(url, user, pass);
	}
	catch(SQLException e){
		out.println("연결 실패");
		out.println("네트워크 연결 상태 또는 Driver 상태를 점검하여 주십시오. ");
	}
    Statement stmt = null;	// Statement object
    ResultSet rs = null;    // Resultset object
    String departmentId = null;
    String departmentName = null;
    String sql = ""; // an SQL statement


if (request.getMethod().equalsIgnoreCase("post")) {
    String formIdentifier = request.getParameter("formIdentifier");

    // 폼 식별자에 따라 다른 처리
    if (formIdentifier != null) {
        if (formIdentifier.equals("s_form")) {
            String Customer_ID = request.getParameter("c_id");
         // 고객 정보 조회
            String C_SQL = "SELECT * FROM CUSTOMER_INFO WHERE ID = '" + Customer_ID+"'";
            try {
                stmt = conn.createStatement();
                rs = stmt.executeQuery(C_SQL);
				
                out.println("<br />");
                out.println("<br />");
                if (!rs.next()) {
                    out.println("고객 정보가 없습니다.");
                }
                else
                {
                	ResultSetMetaData rsmd = rs.getMetaData();
                	out.println("<table border=\"1\">");
                	int cnt = rsmd.getColumnCount();
                	for (int i=1;i<=cnt;i++)
                	{
                		out.println("<th>"+rsmd.getColumnName(i)+"</th>");
                	}
                	
                	
                        String FName = rs.getString("FNAME");
                        String LName = rs.getString("LNAME");
                        String name = rs.getString("NAME");
                        String gender = rs.getString("GENDER");
                        String email = rs.getString("EMAIL");
                        String Id = rs.getString("ID");
                        String passwd = rs.getString("PW");
                        String phone = rs.getString("PHONE_NUMBER");
                        String birth = rs.getString("BIRTH_DATE");
                		out.println("<tr>");
                	    out.println("<td>"+FName+"</td>");
                	    out.println("<td>"+LName+"</td>");
                	    out.println("<td>"+name+"</td>");
                	    out.println("<td>"+gender+"</td>");
                	    out.println("<td>"+email+"</td>");
                	    out.println("<td>"+Id+"</td>");
                	    out.println("<td>"+passwd+"</td>");
                	    out.println("<td>"+phone+"</td>");
                	    out.println("<td>"+birth+"</td>");

                	    out.println("</tr>");
                	    

                	
              
                	out.println("</table>");

                
                }
            } catch (SQLException e) {
                out.println("고객 정보 조회에 실패했습니다.");
            }
        
        }
    }
}


%>
	
<br />
고객 정보 삭제(ID를 입력하여 주십시오.)
<br />
<br />
	<form action="customer.jsp" method="post" accept-charset="utf-8">
        <label for="del_id">ID: </label>
        <input type="text" id="del_id" name="del_id"><br><br>
		<input type="hidden" name="formIdentifier" value="d_form">
		<input type="submit" value="Submit">
	</form>
<br />
<%

if (request.getMethod().equalsIgnoreCase("post")) {
    String formIdentifier = request.getParameter("formIdentifier");

    // 폼 식별자에 따라 다른 처리
    if (formIdentifier != null) {
        if (formIdentifier.equals("d_form")) {
        	
            String Delete_ID = request.getParameter("del_id");

            String Delete_sql = "DELETE FROM CUSTOMER_INFO WHERE ID = '" + Delete_ID+"'";
            try {
                stmt = conn.createStatement();
                rs = stmt.executeQuery(Delete_sql);
                conn.commit();
                out.println("<script>");

                out.println("alert('고객 정보 삭제에 성공하였습니다. ');");

                out.println("</script>");
                out.println("고객 정보 삭제 성공");
            } catch (SQLException e) {
            /* 	out.println(Delete_sql);
            	out.println(e); */
            	String ErrorMessage = e.toString();
                out.println("<script>");
				
                out.println("alert('고객 정보 삭제에 실패하였습니다. 무결성 제약 조건을 확인하여 주십시오. (글을 작성한 회원의 경우 글을 삭제한 후 계정을 삭제할 수 있습니다.)');");
             
                out.println("</script>");
               	
                out.println("고객 정보 삭제에 실패했습니다.<br />");
                out.println("Error Code: "+e.toString());
            }
        	
        	
        	
        
        }
    }
}


%>

<br />
로그아웃
	<form action="logout.jsp" method="post" accept-charset="utf-8">
		<input type="submit" value="로그아웃">
	</form>
</body>
</html>