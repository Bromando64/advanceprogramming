package controller.dbconnection;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import model.PasswordEncryptionWithAes;
import model.User;
import resources.MyConstants;
public class DbConnection {
	public Connection getConnection() {
		try {
			Class.forName(MyConstants.DRIVER_NAME);
			Connection connection = DriverManager.getConnection(
					MyConstants.DB_URL,
					MyConstants.DB_USER_NAME,
					MyConstants.DB_USER_PASSWORD);
			return connection;
		}catch (SQLException | ClassNotFoundException ex) {
			ex.printStackTrace();
			return null;
		}
	}
	
	public ResultSet selectAllQuery(String query) {
		Connection dbConnection = getConnection();
		if(dbConnection != null) {
			try {
				PreparedStatement statement = dbConnection.prepareStatement(query);
				ResultSet result = statement.executeQuery();
				return result;
			} catch (SQLException e) {
				return null;
			}
		}else {
			return null;
		}
	}
	
	public Boolean isUserRegistered(String query, String email, String password) {
		Connection dbConnection = getConnection();
		if(dbConnection != null) {
			try {
				PreparedStatement statement = dbConnection.prepareStatement(query);
				statement.setString(1, email);
				ResultSet result = statement.executeQuery();
				if(result.next()) {
					String userDb = result.getString("email");
					String passwordDb  = result.getString("password");
					String decryptedPwd = PasswordEncryptionWithAes.decrypt(passwordDb, email);
					if(decryptedPwd!=null && userDb.equals(email) && decryptedPwd.equals(password)) return true;
					else return false;
				}else return false;
			} catch (SQLException e) { return null; }
		}else { return null; }
	}
	
	
	public Boolean isUserAlreadyRegistered(String email) {
		Connection dbConnection = getConnection();
		if(dbConnection != null) {
			try {
				PreparedStatement statement = dbConnection.prepareStatement(MyConstants.CHECK_LOGIN_INFO);
				statement.setString(1, email);
				ResultSet result = statement.executeQuery();
				if(result.next()) {
					return true;
				}else return false;
			} catch (SQLException e) { return null; }
		}else { return null; }
	}
	
	
	public int registerUser(String query, User userModel) {
		Connection dbConnection = getConnection();
		if(dbConnection != null) {
			try {
				if(isUserAlreadyRegistered(userModel.getEmail())) return -1;
				
				PreparedStatement statement = dbConnection.prepareStatement(query);
				statement.setString(1, userModel.getFirstName());
				statement.setString(2, userModel.getLastName());
				statement.setString(3, userModel.getPhoneNumber());
				statement.setString(4, userModel.getAddress());
				statement.setString(5, userModel.getEmail());
				statement.setString(6, PasswordEncryptionWithAes.encrypt(
						userModel.getEmail(), userModel.getPassword()));
				statement.setString(7, userModel.getImageUrlFromPart());
				
				int result = statement.executeUpdate();
				if(result>=0) return 1;
				else return 0;
			} catch (Exception e) {
				e.printStackTrace();
				return -2; 
			}
		}else {
			
		return -3;
		
		}
	}
	
	public Boolean updateUser(String query, User userModel, String email) {
		Connection dbConnection = getConnection();
		if (dbConnection != null) {
			try {
				PreparedStatement statement = dbConnection.prepareStatement(query);
				statement.setString(1, userModel.getFirstName());
				statement.setString(2, userModel.getLastName());
				statement.setString(3, userModel.getPhoneNumber());
				statement.setString(4, userModel.getAddress());
				statement.setString(5, userModel.getEmail());
				statement.setString(6, PasswordEncryptionWithAes.encrypt(
						userModel.getEmail(), userModel.getPassword()));
				statement.setString(7, userModel.getImageUrlFromPart());
				statement.setString(8, email);
				int result = statement.executeUpdate();
				if (result>=0) return true;
				else return false;
			}catch (SQLException e) {
				e.printStackTrace();
				return false;
			}
		}else {
			return false;
		}
	}
	
	
}
