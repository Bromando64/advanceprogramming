package controller.product;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.dbconnection.DbConnection;
import model.Product;
import resources.MyConstants;

/**
 * Servlet implementation class UpdateProductServlet
 */
@WebServlet("/UpdateProductServlet")
public class UpdateProductServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UpdateProductServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int productID = Integer.parseInt(request.getParameter("productID"));
		String product_name = request.getParameter("productName");
		String brand = request.getParameter("brand");
		String category = request.getParameter("category");
		double price = Double.parseDouble(request.getParameter("price"));
		int quantity = Integer.parseInt(request.getParameter("quantity"));
		int sold = Integer.parseInt(request.getParameter("sold"));
		
		
		Product productModel = new Product(product_name, brand, category, price, quantity, sold);
		
		DbConnection con = new DbConnection();
		
		boolean result = con.updateProduct(MyConstants.PRODUCT_UPDATE, productModel, productID);
		
		if (result == true) {
			response.sendRedirect(request.getContextPath()+"/Pages/admin_profile.jsp");
		}else {
			response.sendRedirect(request.getContextPath()+"/Pages/admin_profile.jsp");
		}
	}

}
