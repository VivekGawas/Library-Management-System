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
        background-color: rgb(230, 181, 255);
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
    <h1 style="background-color: black; color: white; width: 65%; border: 2px solid yellow; border-radius: 25px;">Return a Book</h1>

    <form action="" method="post">
    Enter Rno: <input type="text" name="rno" required ><br><br>
    Enter Title of book : <input type="text" name="title" required ><br><br>
    Enter book author: <input type="text" name="author"><br><br>
    <input type="submit" name="btnReturn" value="return">
</form>

<%
    if(request.getParameter("btnReturn")!=null){

        String rno=request.getParameter("rno");
        String title=request.getParameter("title");
        String author=request.getParameter("author");

        try{
        DriverManager.registerDriver(new com.mysql.cj.jdbc.Driver());
		String url="jdbc:mysql://localhost:3306/LibMngSys_proj";
		
		Connection con=DriverManager.getConnection(url,"root","Harsh@12345");
		String sql= "delete from isbks where rno=? and btitle=? and bauthor=?";
        PreparedStatement pst;
		pst=con.prepareStatement(sql);
        pst.setString(1,rno);
        pst.setString(2,title);
        pst.setString(3,author);
        int rows=pst.executeUpdate();

        if(rows!=0){
            String sql1="select bprice from avlbks where btitle=?";
            String sql2= "insert into avlbks values(default, ?, ?, ?)";
		    PreparedStatement pst1=con.prepareStatement(sql2);
            PreparedStatement pst2=con.prepareStatement(sql1);
            pst2.setString(1,title);
            ResultSet rs=pst2.executeQuery();
            rs.next();
            int price=rs.getInt(1);

            pst1.setString(1,title);
            pst1.setString(2,author);
            pst1.setInt(3,price);
            pst1.executeUpdate();
            out.println("Book: "+title+", returned by "+rno);
        }
        else{
            out.println("Book not issued by the student");
        }
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
<input type="submit" value="logout" name="btn" id="btnLogout"  >
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