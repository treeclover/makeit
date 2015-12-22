<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page import = "java.sql.*, java.io.*" %>
<%@ page import = "java.util.HashMap" %>
<%@ page import = "org.json.*, org.json.simple.*" %>
<%
	request.setCharacterEncoding("euc-kr");
	JSONObject messages = new JSONObject();
	JSONArray array = new JSONArray();
	int num = 0, cnt = 0;
	String title = null, name = null, message = null;
	Connection conn = null;
    Statement stmt = null;
%>
<HTML>
	<HEAD>
		<TITLE>����</TITLE>
	</HEAD>
	<BODY>
		<%
			try {
				Class.forName("com.mysql.jdbc.Driver");
				conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/board", "root", "1234");
				if (conn == null)
					throw new Exception("�����ͺ��̽��� ������ �� �����ϴ�.<BR>");
				stmt = conn.createStatement();
				ResultSet rs = stmt.executeQuery("select * from message;");
				rs.afterLast();
				while(rs.previous()) {
					messages = new JSONObject();
					messages.put("sequence", rs.getInt("seq_no"));
					messages.put("title", rs.getString("title"));
					messages.put("author", rs.getString("name"));
					messages.put("message", rs.getString("content"));
					array.add(messages);
				}
				out.print(array);
			} catch (SQLException e) {
				out.println("�ۼ��� ������ �������� �ʽ��ϴ�.");
			} catch (IOException e) {
				out.println("�ۼ��� ������ �������� �ʽ��ϴ�.");
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
		%>
		<FORM action=test_write.html method=POST>
			<input type=submit value='�۾���'>
		</FORM>
	</BODY>
</HTML>