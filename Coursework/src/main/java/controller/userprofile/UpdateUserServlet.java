package controller.userprofile;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import controller.dbconnection.DbConnection;
import model.User;
import resources.MyConstants;

/**
 * Servlet implementation class UpdateUserServlet
 */
@WebServlet(asyncSupported = true, urlPatterns = { "/UpdateUserServlet" })
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
	maxFileSize = 1024 * 1024 * 10, // 10MB
	maxRequestSize = 1024 * 1024 * 50)
public class UpdateUserServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UpdateUserServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		String emailSes = (String) session.getAttribute("email");
		
		String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String address = request.getParameter("address");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String phoneNumber = request.getParameter("phoneNumber");
        Part imagePart = request.getPart("image");
        User userModel = new User(firstName, lastName, address, email, password, phoneNumber, imagePart);
        
        String savePath = MyConstants.IMAGE_DIR_SAVE_PATH;
	    String fileName = userModel.getImageUrlFromPart();
	    
	    if(!fileName.isEmpty() && fileName != null)
    		imagePart.write(savePath + fileName);
	    
	    DbConnection con = new DbConnection();
	    Boolean result = con.updateUser(MyConstants.USER_UPDATE, userModel, emailSes);
	    
	    if (result == true) {
	    	request.setAttribute("updateMessage", "Successfully Updated");
	    	Cookie[] cookies = request.getCookies();
			if(cookies != null) {
				for(Cookie cookie : cookies) {
					cookie.setMaxAge(0);
					response.addCookie(cookie);
				}
			}
			HttpSession session2 = request.getSession(false);
			if(session2 != null) {
				session2.invalidate();
			}
			response.sendRedirect(request.getContextPath()+"/login.jsp");
	    }else {
	    	request.setAttribute("updateMessage", "Error Not updated");
	    	request.getRequestDispatcher("Pages/user_profile.jsp").forward(request, response);
	    }
	}

}
