<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import = "java.sql.*, java.io.*" %>
<%
	request.setCharacterEncoding("utf-8");
	int num = 0, cnt = 0;
	String title = null, name = null, message = null;
	Connection conn = null;
    Statement stmt = null;
%>
<HTML>
	<HEAD>
		<TITLE>방명록</TITLE>
	</HEAD>
	<BODY>
		<%
			try {
				Class.forName("com.mysql.jdbc.Driver");
				conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/board", "root", "1234");
				if (conn == null)
					throw new Exception("데이터베이스에 연결할 수 없습니다.<BR>");
				stmt = conn.createStatement();
				ResultSet rs = stmt.executeQuery("select * from message;");
				rs.afterLast();
				while(rs.previous()) {
					out.println("----------------------------------<BR>");
					num = rs.getInt("seq_no");
					title = rs.getString("title");
					name = rs.getString("name");
					message = rs.getString("content");
		%>
		글번호 : <%= num %> &nbsp;&nbsp;&nbsp; 글쓴이 : <%= name %> <BR>
		제목 : <%= title %><BR><BR>
		<%= message %><BR>
		
		<%
				} 
			} catch (SQLException e) {
				out.println("작성된 방명록이 존재하지 않습니다.");
			} catch (IOException e) {
				out.println("작성된 방명록이 존재하지 않습니다.");
			}
			finally {
				try { 
					stmt.close();
				} 
				catch (Exception ignored) {
				}
				try { 
					conn.close();
				} 
				catch (Exception ignored) {
				}
			}
			if(name != null) {
				out.println("----------------------------------");
			} else {
				out.println("방명록이 존재하지 않습니다.");
			}
		%>
		<FORM action=test_write.html method=POST>
			<input type=submit value='글쓰기'>
		</FORM>
	</BODY>
</HTML>