<%@ page import="java.sql.*"%>
<html>
<head>
    <title>Update Inventory</title>
    <style><%@include file="/css/items.css"%></style>
<%--    <style><%@include file="/css/add.css"%></style>--%>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">
</head>
 
 <body>
	<div class="item-body">
	<h1>Update Inventory</h1>
        <form action="">
		<h3>Please fill in all required* fields, then fill in the fields you would like to update</h3>
			<div class="item-input-container">
                <label for="">Store Inventory ID</label>
                <input placeholder = "Required*" NAME = "storeInventoryID" type="int" />
            </div>
			<div class="item-input-container">
                <label for="">Item Name</label>
                <input placeholder = "Item Name" NAME = "itemsStocked" type="String" />
            </div>			
			<div class="item-input-container">
				<label for="">Number of Stocked items</label>
                <input  placeholder = "Number of Stocked Item" NAME = "inventoryStock" type="int" />
            </div>
			<div class="item-input-container">
                <label for="">Store ID</label>
                <input  placeholder = "Required*" NAME = "storeID"type="int" />
            </div>   
			<div class="item-button-container">
                <button>Update Inventory</button>
            </div>			
        </form>

		<div class="item-button-container">
			<a href="adminHome.jsp">
				<button>Back to Admin Home</button>
			</a>
		</div>
    </div>

  </body>
</html>
