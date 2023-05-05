package resources;

import java.io.File;

public class MyConstants {
	//Database Configuration
	public static final String DRIVER_NAME = "com.mysql.cj.jdbc.Driver";
	public static final String DB_URL = "jdbc:mysql://localhost:3306/coursework";
	public static final String DB_USER_NAME = "root";
	public static final String DB_USER_PASSWORD = "";
	
	//Image Config
	public static final String IMAGE_DIR = "xampp\\tomcat\\webapps\\images\\";
	public static final String IMAGE_DIR_SAVE_PATH = "C:" + File.separator + IMAGE_DIR;
	//Start Region: Query
	public static final String CHECK_LOGIN_INFO = "Select email, password " +"FROM user WHERE email = ?";
	public static final String GET_ALL_INFO = "Select * FROM user";
	public static final String GEt_ALL_INFO_BY_ID = "Select * From user" + "WHERE id=?";
	// End Region: Query
	
	// Start Region: Insert Query
	public static final String USER_REGISTER = "INSERT INTO user"
			+ "(first_name, last_name, phonenumber, address, email, password, imageID)"
			+ " VALUES(?,?,?,?,?,?,?)";
	public static final String USER_UPDATE = "UPDATE user SET first_name = ?, last_name = ?, phonenumber = ?, address = ?, email = ?, password = ?, imageID = ? WHERE email = ?";
	// End Region: Insert Query
}
