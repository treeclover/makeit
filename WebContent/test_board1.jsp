<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import = "java.sql.*, java.io.*" %>
<%@ page import = "java.util.HashMap" %>
<%@ page import = "org.json.*, org.json.simple.*" %>
<%
	request.setCharacterEncoding("utf-8");
	JSONObject messages = new JSONObject();
	JSONArray array = new JSONArray();
	int num = 0, cnt = 0;
	String title = null, name = null, message = null;
	Connection conn = null;
    Statement stmt = null;
	try {
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/board", "root", "1234");
		if (conn == null)
			throw new Exception("데이터베이스에 연결할 수 없습니다.<BR>");
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
		out.println("작성된 방명록이 존재하지 않습니다.");
	} catch (IOException e) {
		out.println("작성된 방명록이 존재하지 않습니다.");
	}
	finally {
		try {
			stmt.close();
		} catch (Exception ignored) {
		}
		try {
			conn.close();
		} catch (Exception ignored) {
		}
	}
%>