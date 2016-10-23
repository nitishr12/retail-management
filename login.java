import java.io.*;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.*;
import com.mysql.jdbc.Connection;

/**
 * Servlet implementation class login
 */
@WebServlet("/login")
public class login extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public login() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
		PrintWriter out = response.getWriter();
        String user = request.getParameter("username");
        String pass = request.getParameter("password");
        out.println("<!DOCTYPE html>");
        out.println("<html>");
        out.println("<head>");
        out.println("<title>Hello World</title>");            
        out.println("</head>");
        out.println("<body>");
        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = (Connection) DriverManager.getConnection("jdbc:mysql://localhost:3306/retail1", "root", "root");
            PreparedStatement pst = conn.prepareStatement("Select first_name,designation,uid from user where username=? and password=?");
            pst.setString(1, user);
            pst.setString(2, pass);
            
            ResultSet rs = pst.executeQuery();
            if (rs.next()) {
            	 out.println("Welcome "+rs.getString(1));
            	 if(rs.getString(2).equals("Warehouse Manager")){
            		 request.setAttribute("name", rs.getString(1));
            		 request.setAttribute("userid", Integer.toString((rs.getInt(3))));
            		 request.getRequestDispatcher("warehouse.jsp").forward(request, response);;
            	 }
            } 
            else {
            	out.println("Incorrect UserName/Password");
            	RequestDispatcher rd1= request.getRequestDispatcher("/index.html");
                rd1.include(request, response);
            }
        } 
        catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
	}

}
