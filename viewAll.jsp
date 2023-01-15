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
        background-color: rgb(107, 216, 99);
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
    <h1 style="background-color: black; color: white; width: 65%; border: 2px solid yellow; border-radius: 25px;">Available Books</h1>
    
<table border="2px" style="width:40%; background-color: rgb(213, 213, 213);">
    <tr>
        <th>Title</th>
        <th>Author</th>
        <th>Stock</th>
    </tr>
<%
    try{
        DriverManager.registerDriver(new com.mysql.cj.jdbc.Driver());
		String url="jdbc:mysql://localhost:3306/LibMngSys_proj";
		
		Connection con=DriverManager.getConnection(url,"root","Harsh@12345");
		String sql= "select count(*), btitle, bauthor from avlbks group by btitle, bauthor order by btitle";
		Statement smt=con.createStatement();
		ResultSet rs=smt.executeQuery(sql);
        while(rs.next()){
                int count=rs.getInt(1);
                String title =rs.getString(2);
                String author=rs.getString(3);

%>  <tr style="text-align:center">
        <td><%=title%></td>
        <td><%=author%></td>
        <td><%=count%></td>
    </tr>
<%
        }
    }
    catch(SQLException se){
        out.println("issue "+se);
    }
%>


</table>

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