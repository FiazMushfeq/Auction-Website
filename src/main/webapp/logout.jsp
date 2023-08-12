<%
    if ((session.getAttribute("user") == null)) {
%>
You are not logged in<br/>
<a href="login.jsp">Please Login</a>
<%} else {
%>
Welcome <%=session.getAttribute("user")%>  //this will display the username that is stored in the session.
<a href='logout.jsp'>Log out</a>
<%
    }
%>
d) logout.jsp
<%
session.invalidate();
session.getAttribute("user");   //this will throw an error
response.sendRedirect("login.jsp");
 
%>