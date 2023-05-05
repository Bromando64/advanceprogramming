package controller.product;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import controller.dbconnection.DbConnection;
import model.Product;
import model.ProductImage;
import resources.MyConstants;

/**
 * Servlet implementation class AddProductServlet
 */
@WebServlet(asyncSupported = true, urlPatterns = { "/AddProductServlet" })
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
	maxFileSize = 1024 * 1024 * 10, // 10MB
	maxRequestSize = 1024 * 1024 * 50)
public class AddProductServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddProductServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String product_name = request.getParameter("productName");
		String brand = request.getParameter("brand");
		String category = request.getParameter("category");
		double price = Double.parseDouble(request.getParameter("price"));
		int quantity = Integer.parseInt(request.getParameter("quantity"));
		int sold = Integer.parseInt(request.getParameter("sold"));
		Part imagePart = request.getPart("image");
		
		Product productModel = new Product(product_name, brand, category, price, quantity, sold);
		
		DbConnection con = new DbConnection();
		int[] result = con.insertProduct(MyConstants.PRODUCT_INSERT, productModel);
		
		if (result[1] == 1) {
			
			
			ProductImage productImageModel = new ProductImage(imagePart, result[0]);
			
			String savePath = MyConstants.IMAGE_DIR_SAVE_PATH;
		    String fileName = productImageModel.getImage_url();
		    
		    if(!fileName.isEmpty() && fileName != null)
	    		imagePart.write(savePath + fileName);
			
		    int resultImg = con.insertProductImage(MyConstants.PRODUCT_IMAGE_INSERT, productImageModel);
			
		    if (resultImg == 1) {
		    	request.setAttribute("productMessage", "Successfully Added");
		    	request.getRequestDispatcher("/Pages/admin_profile.jsp").forward(request, response);
		    }else {
		    	System.out.println("imgerr" + result);
		    	request.getRequestDispatcher("/Pages/admin_profile.jsp").forward(request, response);
		    }
			
		}else if(result[1] == -1) {
			System.out.println(result[1]);
			request.setAttribute("productMessage", "Product Already Exists");
			request.getRequestDispatcher("/Pages/admin_profile.jsp").forward(request, response);
		}else {
			System.out.println(result[1]);
			request.getRequestDispatcher("/Pages/admin_profile.jsp").forward(request, response);
		}
		
	}

}
