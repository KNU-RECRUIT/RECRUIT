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
    
    %>
	     <%
	     String FName = request.getParameter("fname");
	     String LName = request.getParameter("lname");
	     String name = FName+LName;
	     String gender = request.getParameter("gender");
	     String email = request.getParameter("email");
	     String id = request.getParameter("id");
	     String passwd = request.getParameter("password");
	     String phone = request.getParameter("phone");
	     String birth = request.getParameter("birth");

	        // 고객 정보 삽입
	        String sqlcsi = "INSERT INTO CUSTOMER_INFO VALUES (" +
	                "'"+FName + "', " +
	                "'"+LName + "', " +
	                "'"+name + "', " +
	                "'"+gender + "', " +
	                "'"+email + "', " +
	                "'"+id + "', " +
	                "'"+passwd + "', " +
	                "'"+phone + "', " +
	                "TO_DATE('"+birth +"','YYYY-MM-DD')"+ ")";
	        try {
	            stmt = conn.createStatement();
	            rs = stmt.executeQuery(sqlcsi);
	           conn.commit();
	        } catch (SQLException e) {
	        	out.println(sqlcsi);
	            out.println("고객 정보 삽입에 실패했습니다.");
	        }

%>

</body>
</html>