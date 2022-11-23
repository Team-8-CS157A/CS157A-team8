package user;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class usersActions {

    public static void insertIntoTable(java.sql.Connection con, String userEmpAdmin, String firstName, String lastName, String phoneNumber, String storeID, String adminID) {
        try {
            String queryString = "";
            String getNextIDString = "";

            switch(userEmpAdmin) {
                case "Users":
                    queryString = "INSERT INTO Users (userID, FirstName, LastName, phoneNumber, storeID) VALUES (?, ?, ?, ?, ?)";
                    getNextIDString = "SELECT MAX(userID) FROM Users";
                    break;
                case "Admin":
                    queryString = "INSERT INTO AdminUsers (AdminID, FirstName, LastName, phoneNumber, storeID) VALUES (?, ?, ?, ?, ?)";
                    getNextIDString = "SELECT MAX(AdminID) FROM AdminUsers";
                    break;
                case "Emp":
                    queryString = "INSERT INTO EmpUsers (empUserID, FirstName, LastName, phoneNumber, storeID, adminID) VALUES (?, ?, ?, ?, ?, ?)";
                    getNextIDString = "SELECT MAX(EmpID) FROM EmpUsers";
                    break;
            }

            if (queryString.equals("")) {
                System.out.println("Invalid table indicated");
            }

            // Gets the next User/Admin/Emp ID
            // Auto increment didn't work for me so this will do for now
            Statement stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery(getNextIDString);
            rs.next();
            int nextID = rs.getInt(1) + 1;  // column 1 is ID
            String id = Integer.toString(nextID);

            // Set values into the queryString
            PreparedStatement pstatement = con.prepareStatement(queryString);
            pstatement.setString(1, id);
            pstatement.setString(2, firstName);
            pstatement.setString(3, lastName);
            pstatement.setString(4, phoneNumber);
            pstatement.setString(5, storeID);

            if (userEmpAdmin.equals("Emp")) {
                pstatement.setString(6, adminID);
            }

            int insertQuery = 0;
            insertQuery = pstatement.executeUpdate();

            // "Returns either (1) the row count for SQL Data Manipulation Language (DML) statements or (2) 0 for SQL statements that return nothing"
            if (insertQuery == 0) {
                throw new SQLException("");
            }

            // Print to logs the newly created User/AdminUser/EmpUser
            System.out.println("--Adding user to \"Employees\"-- \n" +
                    userEmpAdmin + "ID: " + id +
                    "\nFirstName: " + firstName +
                    "\nLastName: " + lastName +
                    "\nphoneNumber: " + phoneNumber +
                    "\nstoreID: " + storeID +
                    "\nadminID: " + adminID);
        } catch (SQLException e) {
            System.out.println(e);
        }
    }
}
