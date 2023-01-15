<%@page import="java.sql.*"%>
<html>
<head>
<title>Library Management System</title>
<style>
	*{
		font-size: 40px;
	}
	body{
		background-color: rgb(213, 235, 255);
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
color: white; width: 50%; border: 2px solid yellow; border-radius: 20px;" >Signup page</h1><br>
<form method="post">
<input type="text" name="un" placeholder="enter username" required />
<br/><br/>
<input type="password" name="pw1" placeholder="enter password" required />
<br/><br/>
<input type="password" name="pw2" placeholder="repeat password" required />
<br/><br/>
<input type="submit" value="login" name="btn"/>
</form>

<%
 if(request.getParameter("btn")!=null)
{
	
	String un=request.getParameter("un");
	String pw1=request.getParameter("pw1");
	String pw2=request.getParameter("pw2");
	

	if(pw1.equals(pw2)){
	try
	{

		DriverManager.registerDriver(new com.mysql.cj.jdbc.Driver());
		String url="jdbc:mysql://localhost:3306/LibMngSys_proj";
		
		Connection con=DriverManager.getConnection(url,"root","Harsh@12345");
		String sql="insert into users values(?,?)";
		PreparedStatement pst= con.prepareStatement(sql);
	
		pst.setString(1,un);
		pst.setString(2,pw1);
	
		pst.executeUpdate();

		
		con.close();	
		response.sendRedirect("index.jsp");	

	}
	catch(SQLException er)
	{
	out.println("user already register");
%>
	<br><br>
<%	}
}
else{
	out.println("Passwords didn't match");
}

}

%>
<a href="./index.jsp">Already register</a>
</center>
</body>
</html>
