<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<%
    String email = request.getParameter("email");
    String firstName = request.getParameter("firstName");
    String lastName = request.getParameter("lastName");
    String password = request.getParameter("password");

    try {
        ApplicationDB db = new ApplicationDB();	
        Connection con = db.getConnection();
        
        // Assuming the user's ID is stored in the session
        int userId = (int) session.getAttribute("userId");
        
        String query = "UPDATE users SET email = ?, firstName = ?, lastName = ?, password = ? WHERE id = ?";
        PreparedStatement pstmt = con.prepareStatement(query);
        pstmt.setString(1, email);
        pstmt.setString(2, firstName);
        pstmt.setString(3, lastName);
        pstmt.setString(4, password);
        pstmt.setInt(5, userId);
        
        int rowsUpdated = pstmt.executeUpdate();
        
        if (rowsUpdated > 0) {
            // Update the session attributes with the new values
            session.setAttribute("email", email);
            session.setAttribute("firstName", firstName);
            session.setAttribute("lastName", lastName);
        }
        
        pstmt.close();
        con.close();
    } catch (Exception e) {
        // Handle the exception as needed
        out.print(e);
    }

    // Redirect back to the profile page
    response.sendRedirect("userProfile.jsp");
%>
