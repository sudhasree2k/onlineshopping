<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="dbcon.Dbconnection"%>
<%

String uname=(String)session.getAttribute("uname");

String street=(String)session.getAttribute("street");
String hno=(String)session.getAttribute("hno");
String city=(String)session.getAttribute("city");
String country=(String)session.getAttribute("country");
String pincode=(String)session.getAttribute("pincode");

try{
    
    String query="select * from cart where username='"+uname+"'";
    Connection con=Dbconnection.getConnection();
    
    Statement st=con.createStatement();
    ResultSet r=st.executeQuery(query);
    
    while(r.next()){
      
      String id=r.getString(1); 
      String name1=r.getString(6);
    
      
       String query1="select * from addproducts where pid='"+id+"'";
 Statement st1=con.createStatement();
    ResultSet r1=st1.executeQuery(query1);
    String seller=null;
    while(r1.next()){
     
      seller=r1.getString(2);
    }
     
      Statement s9=con.createStatement();
      
      int i=s9.executeUpdate("insert into ordered values(null,'"+uname+"','"+street+"','"+hno+"','"+city+"','"+country+"','"+pincode+"','"+id+"','admin','waiting')");
    
      if(i>0){
         
      String query2="delete from cart where username='"+uname+"'";
      
      Statement st7=con.createStatement();
      int ii=st7.executeUpdate(query2);
      response.sendRedirect("MakePayment.jsp?msg=success");
     }else{
       response.sendRedirect("MakePayment.jsp?msg=failed");  
     }
      
      
      
    
    }
    
}catch(Exception e){
   e.printStackTrace(); 
}

%>