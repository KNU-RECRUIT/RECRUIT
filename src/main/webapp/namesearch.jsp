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
    String mname = request.getParameter("mname");
    
    
     String SQL2 = "SELECT DISTINCT E.NAME, D.CONTACT, D.DEPARTMENT_ID FROM EMPLOYEE_INFO E, DEPARTMENT_INFO D, ANNOUNCEMENT_INFO A WHERE E.ID = D.HEAD_ID AND A.MANAGER_ID = E.ID AND E.NAME='"+mname+"'";
try {
stmt = conn.createStatement();
rs = stmt.executeQuery(SQL2);
ResultSetMetaData rsmd = rs.getMetaData();
out.println("<table border=\"1\">");
int cnt = rsmd.getColumnCount();
for (int i=1;i<=cnt;i++)
{
	out.println("<th>"+rsmd.getColumnName(i)+"</th>");
}
while (rs.next()) {
    String Name = rs.getString(1);
    String Phone = rs.getString(2);
    String Department = rs.getString(3);

	out.println("<tr>");
    out.println("<td>"+Name+"</td>");
    out.println("<td>"+Phone+"</td>");
    out.println("<td>"+Department+"</td>");
    out.println("</tr>");
    
}
out.println("</table>");
} catch (SQLException e) {
out.println("Error: " + e.getMessage());
}

%>
    
</body>
</html>