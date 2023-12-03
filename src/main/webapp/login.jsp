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
    String id = request.getParameter("id");
    String name = request.getParameter("name");
    try {
        sql = "SELECT * FROM EMPLOYEE_INFO" + " WHERE ID = '" + id + "' AND NAME = '" + name + "'";
        stmt = conn.createStatement();
        rs = stmt.executeQuery(sql);
        if (!rs.next()) {
            out.println("인증에 실패하였습니다. 다시 시도하여 주십시오.");
        }
        else {
            departmentId = rs.getString(4);
            out.println(name+"님 환영합니다!");
			
            sql = "SELECT NAME FROM DEPARTMENT_INFO " + "WHERE DEPARTMENT_ID = '" + departmentId + "'";
            stmt = conn.createStatement();
            rs = stmt.executeQuery(sql);
            %>
           	<br />
            <%
            
            if (!rs.next()) {
                out.println("사용자 정보를 불러오지 못하였습니다. ");
            }
            else {
                departmentName = rs.getString(1);
                out.println("("+departmentName+" 부서)<br />");
                out.println("어떻게 도와드릴까요?<br />");
                out.println("<a href='customer.jsp'> 1.고객 관리<a /><br />");
                out.println("<a href='announcement.jsp'> 2.공지글 관리<a /><br />");
                out.println("<a href='post.jsp'> 3.고객 작성글 관리<a /><br />");
                out.println("");
            }
            
        }
    } catch (SQLException e) {
        out.println("Error: " + e.getMessage());
    }
	
	
%>
</body>
</html>