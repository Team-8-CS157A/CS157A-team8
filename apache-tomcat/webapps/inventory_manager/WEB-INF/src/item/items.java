package item;

import dbInfo.dbSetting;

import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;

import jakarta.servlet.*;             // Tomcat 10
import jakarta.servlet.http.*;        // Tomcat 10

public class items extends HttpServlet {

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("getItem doGET()");
        try {
            // Create database connection
            java.sql.Connection con;
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/inventory_manager?autoReconnect=true&useSSL=false", dbSetting.user, dbSetting.password);
            System.out.println(dbSetting.db + " database successfully opened.<br/><br/>");

            ArrayList<String[]> items = new ArrayList<>();

            String queryString = "SELECT * FROM Item";
            PreparedStatement pstatement = con.prepareStatement(queryString);
            ResultSet rs = pstatement.executeQuery();

            while (rs.next()) {
                String[] rowValues = new String[7];

                // ResultSet starts at index 1
//                for (int i = 1; i <= 7; i++) {
//                    rowValues[i - 1] = rs.get(i);
//                }

                /*
                * "Item" Table Schema
                *
                * Name          - String
                * ServingSize   - String
                * Calories      - String
                * Sugar         - String
                * Color         - String
                * Price         - Double
                * StockNumber   - Int
                * */

                rowValues[0] = rs.getString(1);
                rowValues[1] = rs.getString(2);
                rowValues[2] = rs.getString(3);
                rowValues[3] = rs.getString(4);
                rowValues[4] = rs.getString(5);
                rowValues[5] = String.valueOf(rs.getDouble(6));
                rowValues[6] = String.valueOf(rs.getInt(7));



                System.out.print("Adding row: ");
                for (int idx = 0; idx < rowValues.length; idx++) {
                    System.out.println(rowValues[idx]);
                }
                items.add(rowValues);
            }

//            System.out.println("@@@@");
//
//            for(Object iter : items) {
//                System.out.print("new iter: ");
//                System.out.println(iter);
//            }

            con.close();

            request.getSession().setAttribute("items", items);
//            response.setContentType("text/plain"); // sets the content type
//            response.setCharacterEncoding("UTF-8"); // sets the encoding
//            response.getWriter().write(items);

            request.getRequestDispatcher("/items.jsp").forward(request, response);
        } catch(SQLException e) {
            System.out.println("SQLException caught: " + e.getMessage());
        } catch (ClassNotFoundException e) {
            System.out.println("ClassNotFoundException caught: " + e.getMessage());
        }

    }
}
