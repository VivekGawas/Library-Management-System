<%@page import="java.sql.*" %>
<%@page import="java.util.*" %>
<html>
<head>
<title>Library Management System App</title>
<link rel="icon"  href="library.ico">

<style>
	*{
		font-size: 40px;
	}
    body{
        background-color: rgb(158, 158, 158);
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
    <h1 style="background-color: black; color: white; width: 65%; border: 2px solid yellow; border-radius: 25px;">Update</h1>

    <form action="" method="post">
    Enter Rno: <input type="text" name="rno" required ><br><br>
    Enter Title of book : <input type="text" name="title" required ><br><br>
    Enter book author: <input type="text" name="author"><br><br>
    Update no of days to: <input type="number" name="days" required ><br><br>
    <input type="submit" name="btnUpdate" value="update">
</form>

<%
    if(request.getParameter("btnUpdate")!=null){
        String rno=request.getParameter("rno");
        String title=request.getParameter("title");
        String author=request.getParameter("author");
        int days=Integer.parseInt(request.getParameter("days"));

        try{
        DriverManager.registerDriver(new com.mysql.cj.jdbc.Driver());
		String url="jdbc:mysql://localhost:3306/LibMngSys_proj";
		
		Connection con=DriverManager.getConnection(url,"root","Harsh@12345");
		String sql= "update isbks set days=? where rno=? and btitle=? and bauthor=?";
        PreparedStatement pst;
		pst=con.prepareStatement(sql);
        pst.setInt(1,days);
        pst.setString(2,rno);
        pst.setString(3,title);
        pst.setString(4,author);
        pst.executeUpdate();
        out.println("Updated.");
        
        }
        catch(SQLException se){
            out.println("issue "+se);
        }

}
    

if(session.getAttribute("user")!=null)
{
	String user=(String)session.getAttribute("user");
}
else
{
		response.sendRedirect("index.jsp");
}
%>
<br><br>
<form>
<a href="home.jsp">Back</a><br><br>
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