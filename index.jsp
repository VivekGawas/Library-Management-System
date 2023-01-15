<%@page import="java.sql.*"%>
<html>
<head>
<title>Library Management System</title>
<style>
	*{
		font-size: 40px;
	}
	body{
		background-color: rgb(213, 235, 255);;
	}
	a{
		text-decoration: none;
	}
	input{
		border: 2px solid black;
	}
</style>
</head>
<body>
<center>
<h1 style="background-color: black;
color: white; width: 50%; border: 2px solid yellow; border-radius: 20px;">Login page</h1><br>
<form method="post">
<input type="text" name="un" placeholder="enter username"/>
<br/><br/>
<input type="password" name="pw" placeholder="enter password"/>
<br/><br/>
<input type="submit" value="login" name="btn"/>
</form>
<a href="./signup.jsp">New user</a>

<%
 if(request.getParameter("btn")!=null)
{
	
	String un=request.getParameter("un");	
	String pw=request.getParameter("pw");	
	
	try
	{

		DriverManager.registerDriver(new com.mysql.cj.jdbc.Driver());
		String url="jdbc:mysql://localhost:3306/LibMngSys_proj";
		
		Connection con=DriverManager.getConnection(url,"root","Harsh@12345");
		String sql="select * from users where username=? and password=?";
		PreparedStatement pst= con.prepareStatement(sql);
		pst.setString(1,un);
		pst.setString(2,pw);
		
		
		ResultSet rs=pst.executeQuery();
		if(rs.next())
		{
			request.getSession().setAttribute("user",un);
			response.sendRedirect("home.jsp");

		}
		else
		{
%>
		<br><br>
<%			out.println("invalid login");

		}

			

	}
	catch(SQLException er)
	{
		out.println("issue"+ er);

	}

}


%>

</center>
</body>

</html>
