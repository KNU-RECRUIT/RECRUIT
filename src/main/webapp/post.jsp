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
고객 작성글 관리 및 조회
<br />1. 가장 많이 글쓰기한 사용자 및 가장 적게 글쓰기한 사용자 검색
<br />
가장 많이 글 쓴 사용자
<br />
<%
String SQLF = "SELECT C.NAME AS CUSTOMER_NAME, U.AUTHOR_ID, COUNT(U.POST_ID) AS POST_COUNT FROM CUSTOMER_INFO C JOIN USER_POST_INFO U ON C.ID = U.AUTHOR_ID GROUP BY C.NAME, U.AUTHOR_ID HAVING COUNT(U.POST_ID) = (SELECT MAX(POST_COUNT) FROM (SELECT AUTHOR_ID, COUNT(POST_ID) AS POST_COUNT FROM USER_POST_INFO GROUP BY AUTHOR_ID))";
try {
stmt = conn.createStatement();
rs = stmt.executeQuery(SQLF);
ResultSetMetaData rsmd = rs.getMetaData();
out.println("<table border=\"1\">");
int cnt = rsmd.getColumnCount();
for (int i=1;i<=cnt;i++)
{
	out.println("<th>"+rsmd.getColumnName(i)+"</th>");
}
while (rs.next()) {
    String CNAME = rs.getString(1);
    String AID = rs.getString(2);
    int PCNT = rs.getInt(3);

	out.println("<tr>");
    out.println("<td>"+CNAME+"</td>");
    out.println("<td>"+AID+"</td>");
    out.println("<td>"+PCNT+"</td>");
    out.println("</tr>");
    
}
out.println("</table>");
} catch (SQLException e) {
out.println("Error: " + e.getMessage());
}

%>
<br />
가장 적게 글 쓴 사용자
<%
String SQLFM = "SELECT C.NAME AS CUSTOMER_NAME, U.AUTHOR_ID, COUNT(U.POST_ID) AS POST_COUNT FROM CUSTOMER_INFO C JOIN USER_POST_INFO U ON C.ID = U.AUTHOR_ID GROUP BY C.NAME, U.AUTHOR_ID HAVING COUNT(U.POST_ID) = (SELECT MIN(POST_COUNT) FROM (SELECT AUTHOR_ID, COUNT(POST_ID) AS POST_COUNT FROM USER_POST_INFO GROUP BY AUTHOR_ID))";
try {
stmt = conn.createStatement();
rs = stmt.executeQuery(SQLFM);
ResultSetMetaData rsmd = rs.getMetaData();
out.println("<table border=\"1\">");
int cnt = rsmd.getColumnCount();
for (int i=1;i<=cnt;i++)
{
	out.println("<th>"+rsmd.getColumnName(i)+"</th>");
}
while (rs.next()) {
    String CNAME = rs.getString(1);
    String AID = rs.getString(2);
    int PCNT = rs.getInt(3);

	out.println("<tr>");
    out.println("<td>"+CNAME+"</td>");
    out.println("<td>"+AID+"</td>");
    out.println("<td>"+PCNT+"</td>");
    out.println("</tr>");
    
}
out.println("</table>");
} catch (SQLException e) {
out.println("Error: " + e.getMessage());
}

%>
<br />2. 가장 먼저 글쓰기한 사용자 및 가장 최근에 글쓰기한 사용자 검색
<br />
<Button>검색하기</Button>
<br />3. 가장 먼저 수정된 글 및 가장 최근에 수정된 글 검색
<br />
<Button>검색하기</Button>
</body>
</html>