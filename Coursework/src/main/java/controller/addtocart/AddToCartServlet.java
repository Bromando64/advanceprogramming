package controller.addtocart;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import controller.dbconnection.DbConnection;
import controller.statemanagement.SessionManage;

/**
 * Servlet implementation class AddToCartServlet
 */
@WebServlet("/AddToCartServlet")
public class AddToCartServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddToCartServlet() {
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
			int productID = Integer.parseInt(request.getParameter("productID"));
			int quantity = Integer.parseInt(request.getParameter("quantity"));
			addToCart(request, email, productID, quantity);
			
			// Forward the request to the product_list.jsp page
		    RequestDispatcher dispatcher = request.getRequestDispatcher("/Pages/product_list.jsp");
		    dispatcher.forward(request, response);
		} else {
			response.sendRedirect(request.getContextPath() + "/login.jsp");
		}
	}
	
	private void addToCart(HttpServletRequest request, String email, int productID, int quantity) {
		try {
				DbConnection connection = new DbConnection();
				Connection con = connection.getConnection();
				
				
				//Get userID using email
				String getUserIdQuery = "SELECT userID FROM user WHERE email = ?";
				PreparedStatement getUserIdStmt = con.prepareStatement(getUserIdQuery);
				getUserIdStmt.setString(1, email);
				ResultSet userIdResultSet = getUserIdStmt.executeQuery();
				userIdResultSet.next();
				int userId = userIdResultSet.getInt("userID");
				
				//check if the user has a cart, if not create one
				String getCartIdQuery = "SELECT cartID FROM cart WHERE userID = ?";
				PreparedStatement getCartIdStmt = con.prepareStatement(getCartIdQuery);
				getCartIdStmt.setInt(1, userId);
				ResultSet cartIdResultSet = getCartIdStmt.executeQuery();
				int cartId;
				
				if (cartIdResultSet.next()) {
					cartId = cartIdResultSet.getInt("cartID");
				}else {
					//Create new cart if not created
					String createCartQuery = "INSERT INTO cart (userID) VALUES (?)";
					PreparedStatement createCartStmt = con.prepareStatement(createCartQuery, Statement.RETURN_GENERATED_KEYS);
					createCartStmt.setInt(1, userId);
					createCartStmt.executeUpdate();
					ResultSet generatedKeys = createCartStmt.getGeneratedKeys();
					generatedKeys.next();
					cartId = generatedKeys.getInt(1);
				}
				
				// Get current product quantity and sold count
				String getProductDetailsQuery = "SELECT quantity, sold FROM product WHERE productID = ?";
				PreparedStatement getProductDetailsStmt = con.prepareStatement(getProductDetailsQuery);
				getProductDetailsStmt.setInt(1, productID);
				ResultSet productDetailsResultSet = getProductDetailsStmt.executeQuery();
				productDetailsResultSet.next();
				int currentQuantity = productDetailsResultSet.getInt("quantity");
				int currentSold = productDetailsResultSet.getInt("sold");

				// Validate requested quantity
				if (quantity > currentQuantity) {
					// Set an error attribute in the request object
					request.setAttribute("errorMessage", "Requested quantity is more than the available stock.");
					
				} else {
					// Update product quantity and sold count
					String updateProductQuery = "UPDATE product SET quantity = ?, sold = ? WHERE productID = ?";
					PreparedStatement updateProductStmt = con.prepareStatement(updateProductQuery);
					updateProductStmt.setInt(1, currentQuantity - quantity);
					updateProductStmt.setInt(2, currentSold + quantity);
					updateProductStmt.setInt(3, productID);
					updateProductStmt.executeUpdate();

					// Check if the product already exists in the cart
					String checkProductExistsQuery = "SELECT * FROM cartproduct WHERE productID = ? AND cartID = ?";
			        PreparedStatement checkProductExistsStmt = con.prepareStatement(checkProductExistsQuery);
			        checkProductExistsStmt.setInt(1, productID);
			        checkProductExistsStmt.setInt(2, cartId);
			        ResultSet productExistsResultSet = checkProductExistsStmt.executeQuery();
			        
			        if (productExistsResultSet.next()) {
			        	//Update the quantity of the existing product in the cart
			        	int existingQuantity = productExistsResultSet.getInt("quantity");
			            String updateProductQuantityQuery = "UPDATE cartproduct SET quantity = ? WHERE productID = ? AND cartID = ?";
			            PreparedStatement updateProductQuantityStmt = con.prepareStatement(updateProductQuantityQuery);
			            updateProductQuantityStmt.setInt(1, existingQuantity + quantity);
			            updateProductQuantityStmt.setInt(2, productID);
			            updateProductQuantityStmt.setInt(3, cartId);
			            updateProductQuantityStmt.executeUpdate();
			       } else {
			        	//Add the product to the cartproduct table
						String addProductToCartQuery = "INSERT INTO cartproduct (productID, cartID, quantity) VALUES (?,?,?)";
						PreparedStatement addProductToCartStmt = con.prepareStatement(addProductToCartQuery);
						addProductToCartStmt.setInt(1, productID);
						addProductToCartStmt.setInt(2, cartId);
						addProductToCartStmt.setInt(3, quantity);
						addProductToCartStmt.executeUpdate();
			      }
			}
		
		}catch (SQLException e) {
			e.printStackTrace();
		}
	}

}
