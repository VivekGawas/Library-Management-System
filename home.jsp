<html>
<head>
<title>Library Management System</title>
<link rel="icon"  href="library.ico">
<style>
	*{
		font-size: 40px;
	}
	body{
        background-color: rgb(50, 201, 214);
    }
	a{
		text-decoration: none;
		background-color: rgb(221, 199, 0);
		color: black;
		border: 3px solid black;
	}
	a:hover{
        color: rgb(0, 0, 0);
        background-color: rgb(169, 154, 17);
    }
</style>
</head>
<body>
<center>
	<h1 style="background-color: black; color: white; width: 65%; border: 2px solid yellow; border-radius: 25px;">Home page</h1>

<a href="addBook.jsp">Add Book</a><br><br>
<a href="searchBook.jsp">Search Book</a><br><br>
<a href="viewAll.jsp">View All Books</a><br><br>
<a href="issueBook.jsp">Issue Book</a><br><br>
<a href="viewIssued.jsp">View Issued books</a><br><br>
<a href="updateIssued.jsp">Update</a><br><br>
<a href="returnBook.jsp">Return Book</a><br><br>
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
<input type="submit" value="logout" name="btn" style="border: 2px solid black;">
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