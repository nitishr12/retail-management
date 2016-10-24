

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mysql.jdbc.Connection;
import com.sore.model.*;

/**
 * Servlet implementation class executeQuery
 */
@WebServlet("/executeQuery")
public class executeQuery extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public executeQuery() {
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
		//doGet(request, response);
		PrintWriter out = response.getWriter();
		response.setContentType("text/html");
		String order=request.getParameter("order");
		String quantity=request.getParameter("quantity");
		String item_id=request.getParameter("item_id");
		try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = (Connection) DriverManager.getConnection("jdbc:mysql://localhost:3306/retail1", "root", "root");
            PreparedStatement pst = conn.prepareStatement("update warehouse_stock set quantity_available=quantity_available-? where item_id=?") ;
            pst.setInt(1, Integer.parseInt(quantity));
            pst.setInt(2, Integer.parseInt(item_id));
            pst.executeUpdate();
            PreparedStatement pst1 = conn.prepareStatement("update store_order_item set quantity_ordered=quantity_ordered-? where order_id=? and item_id=?") ;
            pst1.setInt(1, Integer.parseInt(quantity));
            pst1.setInt(2, Integer.parseInt(order));
            pst1.setInt(3, Integer.parseInt(item_id));
            pst1.executeUpdate();
            //out.println("Successful");
            request.setAttribute("id", order);
            RequestDispatcher rd1=request.getRequestDispatcher("updateOrders.jsp");
        	rd1.forward(request, response);
		}
		catch(Exception e){
			e.printStackTrace();
		}
	}

}
