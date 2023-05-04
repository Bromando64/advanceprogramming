package controller.checkout;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import controller.dbconnection.DbConnection;
import controller.statemanagement.SessionManage;

/**
 * Servlet implementation class CheckoutServlet
 */
@WebServlet("/CheckoutServlet")
public class CheckoutServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CheckoutServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		String email = (String) session.getAttribute("email");
		
		SessionManage sessionManage = new SessionManage();
		
		if(sessionManage.checkUser(email)) {
			try {
				DbConnection connection = new DbConnection();
				Connection con = connection.getConnection();
				
				//Get userID using email
				String getUserIdQuery = "SELECT userID FROM user WHERE email = ?";
				PreparedStatement getUserIdStmt = con.prepareStatement(getUserIdQuery);
				getUserIdStmt.setString(1, email);
				ResultSet userIdResultSet = getUserIdStmt.executeQuery();
				userIdResultSet.next();
				int userID = userIdResultSet.getInt("userID");
				
				
				
				String insertOrderSQL = "INSERT INTO ordered (userID) VALUES (?)";
				
				PreparedStatement insertOrderStmt = con.prepareStatement(insertOrderSQL, Statement.RETURN_GENERATED_KEYS);
				insertOrderStmt.setInt(1, userID);
				insertOrderStmt.executeUpdate();
				
				// Get the auto-generated order ID
	            ResultSet generatedKeys = insertOrderStmt.getGeneratedKeys();
	            generatedKeys.next();
	            int orderID = generatedKeys.getInt(1);
				
	            
	            // SQL statement to insert the cart items into orderedproduct table
	            String insertOrderedProductSQL = "INSERT INTO orderedproduct (orderID, productID, quantity) SELECT ?, productID, quantity FROM cartproduct WHERE cartID IN (SELECT cartID FROM cart WHERE userID = ?)";
	            PreparedStatement insertOrderedProductStmt = con.prepareStatement(insertOrderedProductSQL);
	            insertOrderedProductStmt.setInt(1, orderID);
	            insertOrderedProductStmt.setInt(2, userID);
	            insertOrderedProductStmt.executeUpdate();
	            
				//SQL statement to delete the cart items
	            
				String deleteCartSQL = "DELETE FROM cart WHERE userID = ?";
				PreparedStatement deleteCartStmt = con.prepareStatement(deleteCartSQL);
				deleteCartStmt.setInt(1, userID);
				deleteCartStmt.executeUpdate();
				
				
			}catch (SQLException ex) {
				ex.printStackTrace();
			}
			response.sendRedirect(request.getContextPath()+"/Pages/product_list.jsp");
			
		} else {
			response.sendRedirect(request.getContextPath() + "/login.jsp");
		}
	}

}
