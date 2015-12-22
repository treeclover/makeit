<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import = "java.sql.*, java.io.*, com.oreilly.servlet.MultipartRequest" %>
<%@ page import = "com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%
	request.setCharacterEncoding("utf-8");
	String title = request.getParameter("title");
	String name = request.getParameter("name");
	String message = request.getParameter("message");
	String filePath = application.getRealPath("/Img/"); //파일 저장 경로 지정
	int maxSize = 1024*1024*10; //파일 최대 크기 지정(10Mb)
	MultipartRequest multi = null;
	if (title == null || name == null || message == null) 
        throw new Exception("방명록 작성 시 빈칸의 내용을 반드시 채우십시오.");
    Connection conn = null;
    Statement stmt = null;
    try {
    	multi = new MultipartRequest(request, filePath, maxSize, "utf-8", new DefaultFileRenamePolicy());
    	File image = multi.getFile("image");	//매개변수로 전 페이지에서 받은 Parameter 넣음.
    	String imgName = multi.getFilesystemName("image");	//매개변수로 전 페이지에서 받은 Parameter 넣음.
        Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/board", "root", "1234");
        if (conn == null)
            throw new Exception("데이터베이스에 연결할 수 없습니다.");
        stmt = conn.createStatement();
        String insertmsg = String.format("insert into imgmsg " +
                  "(title, name, content, image) values ('%s', '%s', '%s', '%s');",
                  title, name, message, imgName);
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
    response.sendRedirect("test_board.jsp");
%>