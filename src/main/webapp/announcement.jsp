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

  @import url('https://fonts.googleapis.com/css2?family=Black+Han+Sans&family=Nanum+Myeongjo&display=swap');


body {
    background-color: lightblue;
    font-family: 'Black Han Sans', sans-serif;
    text-align: center;
    color: #FFFFFF;
}
h1 {
    color: white;
    text-align: center;
    
}
/* body {
    background-color: lightblue;
}

h1 {
    color: white;
    text-align: center;
} */

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

input[type=submit]:hover {
    background-color: #45a049;
}

table {
  border-collapse: collapse;
  width: 100%;
  color: black;
}

table td, table th {
  border: 1px solid #ddd;
  padding: 8px;
}

table tr:nth-child(even){background-color: #f2f2f2;}
table tr:nth-child(odd){background-color: #ffffff;}


table tr:hover {background-color: #ddd;}

table th {
  padding-top: 12px;
  padding-bottom: 12px;
  text-align: left;
  background-color: #FF5C77;
  color: white;
}

.customer-sc .input-box {
  position: relative;
  width: 60%;
  left: 20%;
}

.customer-sc .input-box input {
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
.customer-sc .input-box label {
  position: absolute;
  top:0;
  left: 0;
  padding: 10px 0;
  font-size: 16px;
  color: #fff;
  pointer-events: none;
  transition: .5s;
}

.customer-sc .input-box input:focus ~ label,
.customer-sc .input-box input:valid ~ label {
  top: -20px;
  left: 0;
  color: #03e9f4;
  font-size: 12px;
}

::placeholder {
	color: #ffffff
}


</style>
<meta charset="UTF-8">
<title>RECRUIT: KNU</title>
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
    conn.setTransactionIsolation(Connection.TRANSACTION_SERIALIZABLE);

    Statement stmt = null;	// Statement object
    ResultSet rs = null;    // Resultset object
    String departmentId = null;
    String departmentName = null;
    String sql = ""; // an SQL statement
    
    %>


	직원의 ID로 해당 직원이 쓴 글 검색
	<br />
	<div class="customer-sc">
	
	<form action="idsearch.jsp" method="post" accept-charset="utf-8">
                <div class="input-box">
        
        <input type="text" id="mid" name="mid" placeholder="직원의 ID 입력"><br><br>
        </div>
        <input type="submit" value="검색하기">
    </form>
    </div>
    <br />
    공지를 관리할 수 있는 부서 관리자급 직원 검색
    이름으로 검색
    	<div class="customer-sc">
    
    <form action="namesearch.jsp" method="post" accept-charset="utf-8">
                        <div class="input-box">
        
        <input type="text" id="mname" name="mname" placeholder="이름 입력"><br><br>
        </div>
        <input type="submit" value="검색하기">
    </form>
    </div>
    직원 부서로 검색
    	<div class="customer-sc">
    
    <form action="depsearch.jsp" method="post" accept-charset="utf-8">
                        <div class="input-box">
        
        <input type="text" id="mdep" name="mdep" placeholder="부서 코드 입력"><br><br>
        </div>
        <input type="submit" value="검색하기">
    </form>
    </div>
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
    	<div class="customer-sc">

	<form action="announcement.jsp" method="post" accept-charset="utf-8">
        <label for="pd_id">삭제하려는 글의 ID 입력</label>
                                <div class="input-box">
        
        <input type="text" id="pd_id" name="pd_id"><br><br>
        </div>
        <label for="my_id">삭제 확인을 위해 나의 ID 입력 </label>
                                <div class="input-box">
        
        <input type="text" id="my_id" name="my_id"><br><br>
        </div>
        <input type="submit" value="삭제하기">
        <input type="hidden" name="customer_form_ident" value="post_delete_form">
    </form>
    </div>
       
<%
if (request.getMethod().equalsIgnoreCase("post")) {
    String formIdentifier = request.getParameter("customer_form_ident");

    // 폼 식별자에 따라 다른 처리
    if (formIdentifier != null) {
        if (formIdentifier.equals("post_delete_form")) {
        	
            String Delete_ID = request.getParameter("del_id");
			String MyID = request.getParameter("my_id");

            String SQL4 = "DELETE FROM ANNOUNCEMENT_INFO WHERE MANAGER_ID='"+MyID+"' AND POST_ID='"+Delete_ID+"'";
            String login_user_id = session.getAttribute("recruit_id").toString();
			if(login_user_id.equals(MyID))
			{
				
			

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
			else
			{
				out.println("<script>");
				out.println("alert('ID가 일치하지 않습니다. 내가 작성한 글만 삭제할 수 있습니다.')");
				out.println("</script>");
			}
        	
        
        }
    }
}
	
%>
<br />
	<form action="logout.jsp" method="post" accept-charset="utf-8">
		<input type="submit" class="logout" value="로그아웃">
	</form>
</body>
</html>