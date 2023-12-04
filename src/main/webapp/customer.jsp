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
//폼 데이터가 전송되었을 때 처리
	request.setCharacterEncoding("UTF-8");
	String serverIP = "localhost";
	String strSID = "xe";
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
                out.println("<script>");

                out.println("alert('고객 정보 삭제에 성공하였습니다.');");

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

</body>
</html>