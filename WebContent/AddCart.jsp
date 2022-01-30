<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="dbcon.Dbconnection"%>
<%@page import="java.sql.Connection"%>
<%String pid=request.getParameter("pid");
String pname=request.getParameter("pname");
String type=request.getParameter("pinfo");
String price=request.getParameter("price");
String suid=(String)session.getAttribute("suid");
int p=Integer.parseInt(price);
try{
    Connection con=Dbconnection.getConnection();
                    Statement st1=con.createStatement();
                    ResultSet r=st1.executeQuery("select count(*) from cart where pid='"+pid+"'");
   int count=0;
                    while(r.next()){
        count=r.getInt(1);
        if(count==0){
           Statement st=con.createStatement();
                    int i=st.executeUpdate("insert into cart values('"+pid+"','"+pname+"','"+type+"','"+price+"','waiting','"+suid+"','waiting','1','"+price+"')");
                    if(i>0){
                     response.sendRedirect("Card_Products.jsp");   
                    }else{
                    response.sendRedirect("PDetails.jsp?msg=failed");     
                    }
                      
        }else{
            Statement st2=con.createStatement();
            ResultSet rs=st2.executeQuery("select * from cart where pid='"+pid+"'");
            while(rs.next()){
               int price1=Integer.parseInt(rs.getString("pcost")); 
               int cou=Integer.parseInt(rs.getString("noofproducts")); 
               int finalcount=cou+1;
               int finalcost=p+price1;
               
             Statement st5=con.createStatement();
                    int i=st5.executeUpdate("update cart set pcost='"+finalcost+"',noofproducts='"+finalcount+"'where pid='"+pid+"'");
                    if(i>0){
                     response.sendRedirect("Card_Products.jsp");   
                    }else{
                    response.sendRedirect("PDetails.jsp?msg=failed");     
                    }  
               
            }
        }
    }

                  
}catch(Exception e){
   out.println(e); 
}

%>