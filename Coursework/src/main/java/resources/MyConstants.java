package resources;

import java.io.File;

public class MyConstants {
	//Database Configuration
	public static final String DRIVER_NAME = "com.mysql.jdbc.Driver";
	public static final String DB_URL = "jdbc:mysql://localhost:3306/coursework";
	public static final String DB_USER_NAME = "root";
	public static final String DB_USER_PASSWORD = "";
	
	//Image Config
	public static final String IMAGE_DIR = "xampp\\tomcat\\webapps\\images\\";
	public static final String IMAGE_DIR_SAVE_PATH = "C:" + File.separator + IMAGE_DIR;
	//Start Region: Query
	public static final String CHECK_LOGIN_INFO = "Select email, password " +"From user Where email = ? And password = ?";
	public static final String GET_ALL_INFO = "Select*FROM user";
	public static final String GEt_ALL_INFO_BY_ID = "Select*From user" + "WHERE id=?";
	// End Region: Query
}
