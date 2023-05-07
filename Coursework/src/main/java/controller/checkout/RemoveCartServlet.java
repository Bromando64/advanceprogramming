package controller.checkout;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import controller.dbconnection.DbConnection;
import controller.statemanagement.SessionManage;

/**
 * Servlet implementation class RemoveCartServlet
 */
@WebServlet("/RemoveCartServlet")
public class RemoveCartServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RemoveCartServlet() {
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

		if (sessionManage.checkUser(email)) {
			removeAllItems(request, email);

			// Forward the request to the cart page
			response.sendRedirect(request.getContextPath() + "/Pages/cart_page.jsp");
		} else {
			response.sendRedirect(request.getContextPath() + "/login.jsp");
		}
	}
	
	private void removeAllItems(HttpServletRequest request, String email) {
		try {
			DbConnection connection = new DbConnection();
			Connection con = connection.getConnection();

			// Get userID using email
			String getUserIdQuery = "SELECT userID FROM user WHERE email = ?";
			PreparedStatement getUserIdStmt = con.prepareStatement(getUserIdQuery);
			getUserIdStmt.setString(1, email);
			ResultSet userIdResultSet = getUserIdStmt.executeQuery();
			userIdResultSet.next();
			int userId = userIdResultSet.getInt("userID");

			// Get cartID using userID
			String getCartIdQuery = "SELECT cartID FROM cart WHERE userID = ?";
			PreparedStatement getCartIdStmt = con.prepareStatement(getCartIdQuery);
			getCartIdStmt.setInt(1, userId);
			ResultSet cartIdResultSet = getCartIdStmt.executeQuery();
			cartIdResultSet.next();
			int cartId = cartIdResultSet.getInt("cartID");

			// Get all items from the cart
			String getCartItemsQuery = "SELECT productID, quantity FROM cartproduct WHERE cartID = ?";
			PreparedStatement getCartItemsStmt = con.prepareStatement(getCartItemsQuery);
			getCartItemsStmt.setInt(1, cartId);
			ResultSet cartItemsResultSet = getCartItemsStmt.executeQuery();

			// Iterate through the cart items, update product quantity and sold count
			while (cartItemsResultSet.next()) {
				int productID = cartItemsResultSet.getInt("productID");
				int quantity = cartItemsResultSet.getInt("quantity");

				// Get current product quantity and sold count
				String getProductDetailsQuery = "SELECT quantity, sold FROM product WHERE productID = ?";
				PreparedStatement getProductDetailsStmt = con.prepareStatement(getProductDetailsQuery);
				getProductDetailsStmt.setInt(1, productID);
				ResultSet productDetailsResultSet = getProductDetailsStmt.executeQuery();
				productDetailsResultSet.next();
				int currentQuantity = productDetailsResultSet.getInt("quantity");
				int currentSold = productDetailsResultSet.getInt("sold");

				// Update product quantity and sold count
				String updateProductQuery = "UPDATE product SET quantity = ?, sold = ? WHERE productID = ?";
				PreparedStatement updateProductStmt = con.prepareStatement(updateProductQuery);
				updateProductStmt.setInt(1, currentQuantity + quantity);
				updateProductStmt.setInt(2, currentSold - quantity);
				updateProductStmt.setInt(3, productID);
				updateProductStmt.executeUpdate();
			}

			// Remove all items from the cart
			String removeAllItemsQuery = "DELETE FROM cartproduct WHERE cartID = ?";
			PreparedStatement removeAllItemsStmt = con.prepareStatement(removeAllItemsQuery);
			removeAllItemsStmt.setInt(1, cartId);
			removeAllItemsStmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

}
