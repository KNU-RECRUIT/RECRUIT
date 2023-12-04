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
	String strSID = "";
    String OS = System.getProperty("os.name").toLowerCase();
    if (OS.contains("win")) {
    	strSID = "orcl";
    } else if (OS.contains("mac") || OS.contains("nix") || OS.contains("nux") || OS.contains("sunos")) {
    	
    	strSID = "xe";

    } else {
        out.println("OS 정보가 올바르지 않거나 인식되지 않습니다. UNIX/Linux/macOS/Windows외의 OS 사용 시 본 사이트와 호환되지 않을 수 있습니다.<br />");
    }

%>
<%

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

%>
	<%
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
가장 먼저 글쓰기한 사용자
<%
String SQLT="SELECT NAME, GENDER, EMAIL, ID FROM CUSTOMER_INFO WHERE ID IN (SELECT AUTHOR_ID FROM USER_POST_INFO WHERE START_DATE = (SELECT MIN(START_DATE) FROM USER_POST_INFO)) ORDER BY NAME ASC, ID ASC, GENDER DESC";
try {
stmt = conn.createStatement();
rs = stmt.executeQuery(SQLT);
ResultSetMetaData rsmd = rs.getMetaData();
out.println("<table border=\"1\">");
int cnt = rsmd.getColumnCount();
for (int i=1;i<=cnt;i++)
{
	out.println("<th>"+rsmd.getColumnName(i)+"</th>");
}
while (rs.next()) {
    String CNAME = rs.getString(1);
    String Gender = rs.getString(2);
    String Email = rs.getString(3);
    String EID = rs.getString(4);

	out.println("<tr>");
    out.println("<td>"+CNAME+"</td>");
    out.println("<td>"+Gender+"</td>");
    out.println("<td>"+Email+"</td>");
    out.println("<td>"+EID+"</td>");

    out.println("</tr>");
    
}
out.println("</table>");
} catch (SQLException e) {
out.println("Error: " + e.getMessage());
}

%>
<br />
가장 나중에 글쓰기한 사용자
<br />
<%
String SQLTMIN="SELECT NAME, GENDER, EMAIL, ID FROM CUSTOMER_INFO WHERE ID IN (SELECT AUTHOR_ID FROM USER_POST_INFO WHERE START_DATE = (SELECT MAX(START_DATE) FROM USER_POST_INFO)) ORDER BY NAME ASC, ID ASC, GENDER DESC";
try {
stmt = conn.createStatement();
rs = stmt.executeQuery(SQLTMIN);
ResultSetMetaData rsmd = rs.getMetaData();
out.println("<table border=\"1\">");
int cnt = rsmd.getColumnCount();
for (int i=1;i<=cnt;i++)
{
	out.println("<th>"+rsmd.getColumnName(i)+"</th>");
}
while (rs.next()) {
    String CNAME = rs.getString(1);
    String Gender = rs.getString(2);
    String Email = rs.getString(3);
    String EID = rs.getString(4);

	out.println("<tr>");
    out.println("<td>"+CNAME+"</td>");
    out.println("<td>"+Gender+"</td>");
    out.println("<td>"+Email+"</td>");
    out.println("<td>"+EID+"</td>");

    out.println("</tr>");
    
}
out.println("</table>");
} catch (SQLException e) {
out.println("Error: " + e.getMessage());
}

%>





<br />사용자 정보가 있는 글 중 가장 먼저 수정된 글 및 가장 최근에 수정된 공고의 상태, ID및 수정일자 검색
<br />

공고 상태별 가장 먼저 수정된 글 검색
<br />
<%
String SQLK="SELECT STATUS, POST_ID, LASTLY_UPDATED FROM (SELECT U.STATUS, P.POST_ID, P.LASTLY_UPDATED, ROW_NUMBER() OVER(PARTITION BY U.STATUS ORDER BY P.LASTLY_UPDATED ASC) AS RN FROM USER_POST_INFO U JOIN POST_INFO P ON U.POST_ID = P.POST_ID) WHERE RN = 1";

try {
stmt = conn.createStatement();
rs = stmt.executeQuery(SQLK);
ResultSetMetaData rsmd = rs.getMetaData();
out.println("<table border=\"1\">");
int cnt = rsmd.getColumnCount();
for (int i=1;i<=cnt;i++)
{
	out.println("<th>"+rsmd.getColumnName(i)+"</th>");
}
while (rs.next()) {
    String Status = rs.getString(1);
    String Post_ID = rs.getString(2);
    String LUP = rs.getString(3);

	out.println("<tr>");
    out.println("<td>"+Status+"</td>");
    out.println("<td>"+Post_ID+"</td>");
    out.println("<td>"+LUP+"</td>");

    out.println("</tr>");
    
}
out.println("</table>");
} catch (SQLException e) {
out.println("Error: " + e.getMessage());
}

%>
<br />
공고 상태별 가장 최근에 수정된 글 검색 
<br />
<%
String SQLKMAX="SELECT STATUS, POST_ID, LASTLY_UPDATED FROM (SELECT U.STATUS, P.POST_ID, P.LASTLY_UPDATED, ROW_NUMBER() OVER(PARTITION BY U.STATUS ORDER BY P.LASTLY_UPDATED DESC) AS RN FROM USER_POST_INFO U JOIN POST_INFO P ON U.POST_ID = P.POST_ID) WHERE RN = 1";

try {
stmt = conn.createStatement();
rs = stmt.executeQuery(SQLKMAX);
ResultSetMetaData rsmd = rs.getMetaData();
out.println("<table border=\"1\">");
int cnt = rsmd.getColumnCount();
for (int i=1;i<=cnt;i++)
{
	out.println("<th>"+rsmd.getColumnName(i)+"</th>");
}
while (rs.next()) {
    String Status = rs.getString(1);
    String Post_ID = rs.getString(2);
    String LUP = rs.getString(3);

	out.println("<tr>");
    out.println("<td>"+Status+"</td>");
    out.println("<td>"+Post_ID+"</td>");
    out.println("<td>"+LUP+"</td>");

    out.println("</tr>");
    
}
out.println("</table>");
} catch (SQLException e) {
out.println("Error: " + e.getMessage());
}

%>



</body>
</html>