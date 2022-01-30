<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="dbcon.Dbconnection"%>
<%String uname=request.getParameter("uname");
String pass=request.getParameter("pass");
try
{
  
      Connection con=Dbconnection.getConnection();
      Statement st=con.createStatement();
      ResultSet r=st.executeQuery("select * from admin where username='"+uname+"'and password='"+pass+"'");
      if(r.next())
      {
          response.sendRedirect("AdminHome.jsp?msg=success");     
          }
      else{
       response.sendRedirect("Login.jsp?msg=failed");   
              }  
  }
catch(Exception e){
   out.println(e); 
}%>