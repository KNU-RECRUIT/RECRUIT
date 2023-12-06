

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

@import url("https://fonts.googleapis.com/css2?family=Nanum+Myeongjo&display=swap");
@import url("https://fonts.googleapis.com/css?family=Open+Sans:400,400i,700");


body {
    background-color: lightblue;
    text-align: center;
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


span {
font-family: 'Nanum Myeongjo', serif;
}

:root {
/*   --backgroundColor: rgba(246, 241, 209);
 */  --colorShadeA: rgb(106, 163, 137);
  --colorShadeB: rgb(121, 186, 156);
  --colorShadeC: rgb(150, 232, 195);
  --colorShadeD: rgb(187, 232, 211);
  --colorShadeE: rgb(205, 255, 232);
}

* {
  box-sizing: border-box;
}
*::before,
*::after {
  box-sizing: border-box;
}
body {
  font-family: "OpenSans", sans-serif;
  font-size: 1rem;
  line-height: 2;
/*    display: flex;
    */align-items: center;
   justify-content: center; 
  margin: 0;
  min-height: 100vh;
  background: var(--backgroundColor);
}
button {
   position: relative;
   display: inline-block;
  cursor: pointer;
  outline: none;
  margin: auto;
/*   margin-left: 35%;
 */  border: 0;
  vertical-align: middle;
  text-decoration: none;
  font-size: 1.5rem;
  color: var(--colorShadeA);
  font-weight: 700;
  text-transform: uppercase;
  font-family: inherit;
  width: 30%;
}

button.big-button {
  padding: 1em 2em;
  border: 2px solid var(--colorShadeA);
  border-radius: 1em;
  background: var(--colorShadeE);
  transform-style: preserve-3d;
  transition: all 175ms cubic-bezier(0, 0, 1, 1);
}
button.big-button::before {
  position: absolute;
  content: "";
  width: 100%;
  height: 100%;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: var(--colorShadeC);
  border-radius: inherit;
  box-shadow: 0 0 0 2px var(--colorShadeB), 0 0.75em 0 0 var(--colorShadeA);
  transform: translate3d(0, 0.75em, -1em);
  transition: all 175ms cubic-bezier(0, 0, 1, 1);
}

button.big-button:hover {
  background: var(--colorShadeD);
  transform: translate(0, 0.375em);
}

button.big-button:hover::before {
  transform: translate3d(0, 0.75em, -1em);
}

button.big-button:active {
  transform: translate(0em, 0.75em);
}

button.big-button:active::before {
  transform: translate3d(0, 0, -1em);

  box-shadow: 0 0 0 2px var(--colorShadeB), 0 0.25em 0 0 var(--colorShadeB);
}


h1 {
  position: relative;
  padding: 0;
  margin: 0;
  font-family: "Raleway", sans-serif;
  font-weight: 300;
  font-size: 40px;
  color: #080808;
  -webkit-transition: all 0.4s ease 0s;
  -o-transition: all 0.4s ease 0s;
  transition: all 0.4s ease 0s;
}

.title h1 {
  text-align: center;
  text-transform: uppercase;
  padding-bottom: 5px;
}
.title h1:before {
  width: 28px;
  height: 5px;
  display: block;
  content: "";
  position: absolute;
  bottom: 3px;
  left: 50%;
  margin-left: -14px;
  background-color: #b80000;
}
.title h1:after {
  width: 100px;
  height: 1px;
  display: block;
  content: "";
  position: relative;
  margin-top: 25px;
  left: 50%;
  margin-left: -50px;
  background-color: #b80000;
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
	
	request.setCharacterEncoding("UTF-8");
	
    String DBuser = request.getParameter("DBuser");
    String DBpass = request.getParameter("DBpass");
    
	String serverIP = "localhost";
	String portNum = "1521";
	String user = DBuser;
	String pass = DBpass;
	String url = "jdbc:oracle:thin:@"+serverIP+":"+portNum+":"+strSID;
	

	Connection conn = null;
	PreparedStatement pstmt;
	Class.forName("oracle.jdbc.driver.OracleDriver");
	try{
	conn = DriverManager.getConnection(url, user, pass);
	}
	catch(SQLException e){
		out.println("<script>");
		out.println("alert('데이터베이스 연결에 실패하였습니다. 네트워크 상태 또는 JDBC Driver 상태, 데이터베이스의 사용자 ID및 비밀번를 점검하여 주십시오.')");
		out.println("location.href='main.jsp';");
		out.println("</script>");
	}
    Statement stmt = null;	// Statement object
    ResultSet rs = null;    // Resultset object
    String departmentId = null;
    String departmentName = null;
    String sql = ""; // an SQL statement
    
    out.println("<div class=\"title\"><h1>RECRUIT: KNU</h1></div>");
    
    if(conn==null)
    {
    	out.println("<script>");
    	out.println("alert('데이터베이스 사용자 ID 또는 비밀번호를 확인하여 주시기 바랍니다.')");
		out.println("location.href='main.jsp';");
    	out.println("</script>");
    }
    else
    {
        conn.setTransactionIsolation(Connection.TRANSACTION_SERIALIZABLE);

    String id = request.getParameter("id");
    String name = request.getParameter("name");
    try {
        sql = "SELECT * FROM EMPLOYEE_INFO" + " WHERE ID = '" + id + "' AND NAME = '" + name + "'";
        stmt = conn.createStatement();
        rs = stmt.executeQuery(sql);
        if (!rs.next()) {
        	out.println("<script>");
            out.println("alert('인증에 실패하였습니다. 다시 시도하여 주십시오.')");
            out.println("location.href='main.jsp';");
            out.println("</script>");
            
        }
        else {
            departmentId = rs.getString(4);
            String sessionName1 = "recruit_id";
            String sessionToken1 = id;
            String sessionName2 = "recruit_name";
            String sessionToken2 = name;
			session.setAttribute(sessionName1, sessionToken1);
			session.setAttribute(sessionName2, sessionToken2);
			
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
/*                 out.println("("+departmentName+" 부서)<br />");

 */                
 out.println("<span>"+name+"("+departmentName+")님 환영합니다!<br />");

 out.println("어떻게 도와드릴까요?<br /></span>");
                out.println("<br /><br /><button class='big-button' onclick=\"location.href='customer.jsp'\">고객 관리</button>");
                out.println("<br />");
                out.println("<br />");
                out.println("<button class='big-button' onclick=\"location.href='announcement.jsp'\">공지글 관리</button>");
                out.println("<br />");
                out.println("<br />");
                out.println("<button class='big-button' onclick=\"location.href='post.jsp'\">고객 작성글 관리</button>");
                out.println("<br />");
                out.println("<br />");
                
/*                 out.println("<a href='customer.jsp'> 1.고객 관리<a /><br />");
                out.println("<a href='announcement.jsp'> 2.공지글 관리<a /><br />");
                out.println("<a href='post.jsp'> 3.고객 작성글 관리<a /><br />"); */
            }
            
        }
    } catch (SQLException e) {
        out.println("Error: " + e.getMessage());
    }
    }
	
%>
</body>
</html>