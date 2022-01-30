<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="dbcon.Dbconnection"%>
<%

String name=request.getParameter("name");
String email=request.getParameter("email");
String mobile=request.getParameter("mobile");
String type=request.getParameter("type");
String uname=request.getParameter("uname");
String pass=request.getParameter("pass");
try{
    Connection con=Dbconnection.getConnection();
    Statement st=con.createStatement();
    int i=st.executeUpdate("insert into user values(null,'"+name+"','"+email+"','"+mobile+"','"+type+"','"+uname+"','"+pass+"')");
    if(i>0){
       response.sendRedirect("Login.jsp?msg=success"); 
    }else{
       response.sendRedirect("Login.jsp?msg=failed");  
    }
}catch(Exception e){
   out.println(e); 
}



%>