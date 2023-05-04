<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="controller.dbconnection.DbConnection"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/Pages/CSS/signup.css" />

</head>
<body style="background-image:url('${pageContext.request.contextPath}/Pages/Images/background.png')">
	<jsp:useBean id="user" class="Coursework.User" scope="page"/>
	<jsp:setProperty property="" name="user"/>
	<% 
		int imageid = 23;
		int addressid =23;
		DbConnection Connection= new DbConnection();
		Connection con = Connection.getConnection();
		String querysignup = "Insert into user(first_name,last_name,phonenumber,email,password,imageID,addressID) values(?,?,?,?,?,?,?)";
		String querylogin = "Insert into login(email,password) values(?,?)";
		String queryaddress = "Insert into Address(city,area,adress) values(?,?)";
		PreparedStatement stsignup = con.prepareStatement(querysignup);
		PreparedStatement stlogin = con.prepareStatement(querylogin);
		PreparedStatement staddress = con.prepareStatement(queryaddress);
		stsignup.setString(1,user.getFirstname());
		stsignup.setString(2,user.getLastname());
		stsignup.setLong(3,user.getPhonenumber());
		stsignup.setString(4,user.getEmail());
		stsignup.setString(5,user.getPassword());
		stsignup.setInt(6,imageid);
		stsignup.setInt(7,addressid);
		stsignup.setString(7,user.getPassword());
		stlogin.setString(1,user.getEmail());
		stlogin.setString(2,user.getPassword());
		staddress.setString(1,user.getCity());
		staddress.setString(2,user.getArea());
		staddress.setString(3,user.getAddress());
		
		int row=stsignup.executeUpdate();
		int row1=stlogin.executeUpdate();
		int row2=staddress.executeUpdate();
		
		if((row >0)&&(row1 >0)&&(row2 >0))
		{
			%><b>The data is inserted</b>
			<%
		}
		else
		{
			%><b>The data is not inserted</b>
			<%
		}
		
	%>
</body>
	
</html>