package Coursework;
import java.io.Serializable;

public class User implements Serializable{
	
	
	private String firstname, lastname, address,area ,city, email,password;
	private long phonenumber;
	
	public String getFirstname()
	{
		return firstname;
	}
	public void setFirstName(String firstname)
	{
		this.firstname=firstname;
	}
	public String getLastname()
	{
		return lastname;
	}
	public void setLastName(String lastname)
	{
		this.lastname=lastname;
	}
	public String getAddress()
	{
		return address;
	}
	public void setAddress(String address)
	{
		this.address=address;
	}
	public String getArea()
	{
		return area;
	}
	public void setArea(String area)
	{
		this.area=area;
	}
	public String getCity()
	{
		return city;
	}
	public void setCity(String city)
	{
		this.city=city;
	}
	public String getEmail()
	{
		return email;
	}
	public void setEmail(String email)
	{
		this.email=email;
	}
	public String getPassword()
	{
		return password;
	}
	public void setPassword(String password)
	{
		this.password=password;
	}
	public long getPhonenumber()
	{
		return phonenumber;
	}
	public void setPhonenuber(long phonenumber)
	{
		this.phonenumber=phonenumber;
	}
}
