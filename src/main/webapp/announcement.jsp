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
  	
<br />
내가 쓴 글 삭제
<br />
	<form action="announcement.jsp" method="post" accept-charset="utf-8">
        <label for="pd_id">삭제하려는 글의 ID 입력</label>
        <input type="text" id="pd_id" name="pd_id"><br><br>
        <label for="my_id">삭제 확인을 위해 나의 ID 입력 </label>
        <input type="text" id="my_id" name="my_id"><br><br>
        
        <input type="submit" value="Submit">
        <input type="hidden" name="customer_form_ident" value="post_delete_form">
    </form>
       
<%
if (request.getMethod().equalsIgnoreCase("post")) {
    String formIdentifier = request.getParameter("customer_form_ident");

    // 폼 식별자에 따라 다른 처리
    if (formIdentifier != null) {
        if (formIdentifier.equals("post_delete_form")) {
        	
            String Delete_ID = request.getParameter("del_id");
			String MyID = request.getParameter("my_id");

            String SQL4 = "DELETE FROM ANNOUNCEMENT_INFO WHERE MANAGER_ID='"+MyID+"' AND POST_ID='"+Delete_ID+"'";


            try {
                stmt = conn.createStatement();
                int cnt = stmt.executeUpdate(SQL4);
                if(cnt>=1)
                {
                    String dsql = "DELETE FROM POST_INFO WHERE POST_ID='"+Delete_ID+"'";
                    String dsql2 = "DELETE FROM USER_POST_INFO WHERE POST_ID='"+Delete_ID+"'";
                    stmt.executeUpdate(dsql);
                    stmt.executeUpdate(dsql2);
                }

                out.println("<script>alert('삭제가 완료되었습니다. ');</script>");
            } catch (SQLException e) {
            	out.println("<script>alert('삭제에 실패하였습니다. ');</script>");
                out.println("Error: " + e.getMessage());
            }

        	
        	
        
        }
    }
}
	
%>
</body>
</html>