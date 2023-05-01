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

}
