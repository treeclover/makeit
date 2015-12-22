<%@ page language="java" contentType="application/json; charset=utf-8" %>
<%@ page import = "java.sql.*, java.io.*" %>
<%
	request.setCharacterEncoding("utf-8");
	String title = request.getParameter("title");
	String name = request.getParameter("author");
	String message = request.getParameter("content");
	if (title == null || name == null || message == null) 
        throw new Exception("방명록 작성 시 빈칸의 내용을 반드시 채우십시오.");
    Connection conn = null;
    Statement stmt = null;
    try {
        Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/board", "root", "1234");
        if (conn == null)
            throw new Exception("데이터베이스에 연결할 수 없습니다.");
        stmt = conn.createStatement();
        String insertmsg = String.format("insert into message " +
                  "(title, name, content) values ('%s', '%s', '%s');",
                  title, name, message);
        int rowNum = stmt.executeUpdate(insertmsg);
        if (rowNum < 1)
            throw new Exception("데이터를 DB에 입력할 수 없습니다.");
    } catch(SQLException e) {
		response.sendRedirect("test_fail.html");
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
    response.sendRedirect("test_board1.jsp");
%>