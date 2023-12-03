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


	직원의 ID로 해당 직원이 쓴 글 검색
	<br />
	<form action="idsearch.jsp" method="post" accept-charset="utf-8">
        <label for="mid">직원의 	ID</label>
        <input type="text" id="mid" name="mid"><br><br>
        <input type="submit" value="Submit">
    </form>
    <br />
    공지를 관리할 수 있는 부서 관리자급 직원 검색
    이름으로 검색
    <form action="namesearch.jsp" method="post" accept-charset="utf-8">
        <label for="mdep">이름</label>
        <input type="text" id="mname" name="mname"><br><br>
        <input type="submit" value="Submit">
    </form>
    직원 부서로 검색
    <form action="depsearch.jsp" method="post" accept-charset="utf-8">
        <label for="mdep">부서</label>
        <input type="text" id="mdep" name="mdep"><br><br>
        <input type="submit" value="Submit">
    </form>
  	전체 검색 결과
  	<br />
  	<%
    String SQLW = "SELECT DISTINCT E.NAME, D.CONTACT, D.DEPARTMENT_ID FROM EMPLOYEE_INFO E, DEPARTMENT_INFO D, ANNOUNCEMENT_INFO A WHERE E.ID = D.HEAD_ID AND A.MANAGER_ID = E.ID";
try {
stmt = conn.createStatement();
rs = stmt.executeQuery(SQLW);
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