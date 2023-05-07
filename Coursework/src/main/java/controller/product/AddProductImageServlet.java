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
import model.ProductImage;
import resources.MyConstants;

/**
 * Servlet implementation class AddProductImageServlet
 */
@WebServlet(asyncSupported = true, urlPatterns = { "/AddProductImageServlet" })
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
	maxFileSize = 1024 * 1024 * 10, // 10MB
	maxRequestSize = 1024 * 1024 * 50)
public class AddProductImageServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddProductImageServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		int productID = Integer.parseInt(request.getParameter("productID"));
		Part imagePart = request.getPart("image");
		
		ProductImage productImageModel = new ProductImage(imagePart, productID);
		
		String savePath = MyConstants.IMAGE_DIR_SAVE_PATH;
	    String fileName = productImageModel.getImage_url();
	    
	    if(!fileName.isEmpty() && fileName != null)
    		imagePart.write(savePath + fileName);
	    
	    DbConnection con = new DbConnection();
	    int resultImg = con.insertProductImage(MyConstants.PRODUCT_IMAGE_INSERT, productImageModel);
	    
	    if (resultImg == 1) {
	    	response.sendRedirect(request.getContextPath()+"/Pages/admin_profile.jsp");
	    }else {
	    	System.out.println("imgerr" + resultImg);
	    	response.sendRedirect(request.getContextPath()+"/Pages/admin_profile.jsp");
	    }
		
	}

}
