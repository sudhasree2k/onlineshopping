
<%@page import="java.sql.Statement"%>

<%@page import="java.sql.Connection"%>
<%String name=request.getParameter("name");
String street=request.getParameter("street");
String hno=request.getParameter("hno");
String city=request.getParameter("city");
String country=request.getParameter("country");
String pincode=request.getParameter("pincode");


session.setAttribute("name",name);
session.setAttribute("street",street);
session.setAttribute("hno",hno);
session.setAttribute("city",city);
session.setAttribute("country",country);
session.setAttribute("pincode",pincode);

try{
  if(session!=null){
    response.sendRedirect("MakePayment.jsp");  
  }
}catch(Exception e){
   out.println(e); 
}

%>