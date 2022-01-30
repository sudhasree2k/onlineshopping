package com.add;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import java.sql.*;

@WebServlet("/AddProducts")
@MultipartConfig(maxFileSize = 16177215)
public class AddProducts extends HttpServlet {

    private String dbURL = "jdbc:mysql://localhost:3306/onlineshopping";
    private String dbUser = "root";
    private String dbPass = "";

    protected void doPost(HttpServletRequest request,
            HttpServletResponse response) throws ServletException, IOException {

        String pid = request.getParameter("pid");
        String pname = request.getParameter("pname");
        String pinfo = request.getParameter("pinfo");
        String pcost = request.getParameter("pcost");
        
        InputStream inputStream = null;
        Part filePart = request.getPart("image");
        if (filePart != null) {

            System.out.println(filePart.getName());
            System.out.println(filePart.getSize());
            System.out.println(filePart.getContentType());


            inputStream = filePart.getInputStream();
        }

        Connection conn = null;
        String message = null;

        try {

           Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection(dbURL, dbUser, dbPass);

            String sql = "INSERT INTO addproducts (pid, pname, pinfo,pcost,image) values (?, ?, ?, ?,?)";
            PreparedStatement statement = conn.prepareStatement(sql);
            statement.setString(1, pid);
            statement.setString(2, pname);
            statement.setString(3, pinfo);
            statement.setString(4, pcost);
     
      
            
            

            if (inputStream != null) {
                statement.setBlob(5, inputStream);
            }

            int row = statement.executeUpdate();
            if (row > 0) {

                System.out.println("image upload sucess");
                response.sendRedirect("AddProducts.jsp?msg= Product Information Added");
            } else {
                response.sendRedirect("AddProducts.jsp?msg= Unable To Add Product information");

            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(AddProducts.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}