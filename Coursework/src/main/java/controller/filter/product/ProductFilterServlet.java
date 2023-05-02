package controller.filter.product;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.dbconnection.DbConnection;
/**
 * Servlet implementation class ProductFilterServlet
 */
@WebServlet("/ProductFilterServlet")
public class ProductFilterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ProductFilterServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String category = request.getParameter("category");
        String searchQuery = request.getParameter("search");
        
        String selectedBrand = null;
        for (String brand : request.getParameterMap().keySet()) {
            if (request.getParameter(brand).equals("on")) {
                selectedBrand = brand;
                break;
            }
        }
        
        DbConnection dbConnection = new DbConnection();

        Connection connection = dbConnection.getConnection();

        List<Integer> productIds = new ArrayList<>();

        // Check if category is empty or null and adjust the query accordingly
        String query;
        if (category == null || category.isEmpty()) {
            query = "SELECT productID FROM product WHERE product_name LIKE ?";
        } else {
            query = "SELECT productID FROM product WHERE category = ? AND product_name LIKE ?";
        }
        
        if (selectedBrand != null) {
        	query = "SELECT productID FROM product WHERE brand = ?";
        }

        try {
            PreparedStatement preparedStatement = connection.prepareStatement(query);
            
            // Set the PreparedStatement parameters based on whether the category is empty or null
            if (category == null || category.isEmpty()) {
                preparedStatement.setString(1, "%" + searchQuery + "%");
            } else {
                preparedStatement.setString(1, category);
                preparedStatement.setString(2, "%" + searchQuery + "%");
            }
            
            if (selectedBrand != null){
            	preparedStatement.setString(1, selectedBrand);
            }

            ResultSet resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                productIds.add(resultSet.getInt("productID"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        request.setAttribute("productIds", productIds);
        request.setAttribute("searchPerformed", true);
        request.getRequestDispatcher("/Pages/product_list.jsp").forward(request, response);
    }


}
