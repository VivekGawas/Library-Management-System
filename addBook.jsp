<%@page import="java.sql.*" %>
<html>
<head>
<title>Library Management System App</title>
<link rel="icon"  href="library.ico">

<style>
	*{
		font-size: 40px;
	}
    body{
        background-color:aquamarine;
    }
    a{
		text-decoration: none;
		background-color: rgb(0, 0, 0);
		color: rgb(255, 254, 254);
	}
    input{
		border: 2px solid black;
	}
</style>
</head>
<body>
<center>
<h1 style="background-color: black; color: white; width: 65%; border: 2px solid yellow; border-radius: 25px;">Add Book</h1>
<form action="" method="post">
    Title: <input type="text" name="title" id=""><br><br>
    Author: <input type="text" name="author" id=""><br><br>
	Price: <input type="number" name="price" placeholder="Rs" ><br><br>
    <input type="submit" name="btnSubmit" value="Add">
</form>
<%
    if(request.getParameter("btnSubmit")!=null){
        String title=request.getParameter("title");
        String author=request.getParameter("author");
		int price=Integer.parseInt(request.getParameter("price"));

        DriverManager.registerDriver(new com.mysql.cj.jdbc.Driver());
		String url="jdbc:mysql://localhost:3306/LibMngSys_proj";
		
		Connection con=DriverManager.getConnection(url,"root","Harsh@12345");
		String sql= "insert into avlbks values(default, ?, ?, ?)";
		PreparedStatement pst= con.prepareStatement(sql);
		pst.setString(1,title);
		pst.setString(2,author);
		pst.setInt(3,price);
        pst.executeUpdate();
        out.println(title+" Book added.");
%>
        <br><br>
<%
        con.close();
    }

%>
<%
if(session.getAttribute("user")!=null)
{
	String user=(String)session.getAttribute("user");
}
else
{
		response.sendRedirect("index.jsp");


}
%>
<form>
<a href="home.jsp">Back</a>
<br><br>
<input type="submit" value="logout" name="btn">
</form>

<%

if(request.getParameter("btn")!=null)
{
	request.getSession().invalidate();
	response.sendRedirect("index.jsp");

}


%>
</center>
</body>
</html>