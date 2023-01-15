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
        background-color: rgb(212, 173, 43);
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

<script>
    function setFocusToTextBox(){
        document.getElementById("myText").focus();
    }
</script>

</head>
<body onload="setFocusToTextBox()">
<center>
    <h1 style="background-color: black; color: white; width: 65%; border: 2px solid yellow; border-radius: 25px;">Search Book</h1>
    <form action="" method="post">
    search by Title: <input type="text" name="title" id="myText" style="border-radius: 25px; padding: 8px 15px;">  
    <input type="submit" name="btnSearch" value="search">
</form>
<table border="2px" style="width:40%; background-color: rgb(213, 213, 213);">
    <tr>
        <th>Title</th>
        <th>Author</th>
        <th>Stock</th>
    </tr>
<%
    if(request.getParameter("btnSearch")!=null){
        String title=request.getParameter("title");
        try{
        DriverManager.registerDriver(new com.mysql.cj.jdbc.Driver());
		String url="jdbc:mysql://localhost:3306/LibMngSys_proj";
		
		Connection con=DriverManager.getConnection(url,"root","Harsh@12345");
		String sql= "select count(*), bauthor from avlbks where btitle=? group by bauthor";
		PreparedStatement pst=con.prepareStatement(sql);
        pst.setString(1,title);
		ResultSet rs=pst.executeQuery();

        int flag=0;
        while(rs.next()){
            flag=1;
            int count=rs.getInt(1);
            String author=rs.getString(2);
%>  <tr style="text-align:center">
        <td><%=title%></td>
        <td><%=author%></td>
        <td><%=count%></td>
    </tr>
<%

        }
        if(flag==0){
            out.println("No books found.");
%>
        <br><br>
<%      }
    }

    catch(SQLException se){
        out.println("issue "+se);
    }
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