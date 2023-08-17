<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="org.json.simple.*,javax.servlet.*"%>

<%
    int categoryId = Integer.parseInt(request.getParameter("categoryId"));

    ApplicationDB db = new ApplicationDB();
    Connection con = db.getConnection();

    String query = "SELECT * FROM body_types WHERE category_id = ?";
    PreparedStatement pstmt = con.prepareStatement(query);
    pstmt.setInt(1, categoryId);

    ResultSet rs = pstmt.executeQuery();

    // Create a JSON array to hold the body types
    JSONArray jsonArray = new JSONArray();

    while (rs.next()) {
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("id", rs.getInt("id"));
        jsonObject.put("name", rs.getString("name"));
        jsonArray.add(jsonObject);
    }

    db.closeConnection(con);

    // Write the JSON array to the response
    out.print(jsonArray.toJSONString());
%>
