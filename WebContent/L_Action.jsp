<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="dbcon.Dbconnection"%>
<%String uname=request.getParameter("uname");
session.setAttribute("uname",uname);
String pass=request.getParameter("pass");
try{
  String suid=(String)session.getAttribute("suid");
      Connection con=Dbconnection.getConnection();
      Statement st=con.createStatement();
      ResultSet r=st.executeQuery("select * from user where username='"+uname+"'and password='"+pass+"'");
      if(r.next()){
         
        Statement std=con.createStatement();
              int i=std.executeUpdate("update cart set username='"+uname+"'where username='"+suid+"'");
              
          
           response.sendRedirect("UHome.jsp?msg=success");     
          }
      else{
       response.sendRedirect("Login.jsp?msg=failed");   
      }
}
catch(Exception e){
   out.println(e); 
}%>