package com.cs336.pkg;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Timer;
import java.util.TimerTask;

public class ApplicationDB {

    private static final long CHECK_INTERVAL = 60 * 1000; // 1 minute

    static {
        Timer timer = new Timer(true);
        timer.scheduleAtFixedRate(new TimerTask() {
            @Override
            public void run() {
                checkAndCloseAuctions();
            }
        }, 0, CHECK_INTERVAL);
    }
	
	public ApplicationDB(){
		
	}
	
	
	
	public Connection getConnection(){
		
		//Create a connection string
		//String connectionUrl = "jdbc:mysql://localhost:3306/schema";
		String connectionUrl = "jdbc:mysql://localhost:3306/schema?useSSL=false&serverTimezone=UTC";
		Connection connection = null;
		
		try {
			//Load JDBC driver - the interface standardizing the connection procedure. Look at WEB-INF\lib for a mysql connector jar file, otherwise it fails.
			Class.forName("com.mysql.jdbc.Driver").newInstance();
		} catch (InstantiationException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IllegalAccessException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		try {
			//Create a connection to your DB
			connection = DriverManager.getConnection(connectionUrl,"root", "root");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return connection;
		
	}
	
	public void closeConnection(Connection connection){
		try {
			connection.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
    private static void closeAuction(int itemId) {
        // Determine the winning bid
        // Handle the transaction process
        // Notify the winner and seller
        // Update the auction status in the database
    }

	
	private static void checkAndCloseAuctions() {
	    ApplicationDB db = new ApplicationDB();
	    Connection con = null;
	    try {
	        con = db.getConnection();
	        // Query to fetch auctions that need to be closed
	        // You might need to adjust the query according to your schema
	        String query = "SELECT * FROM item WHERE closing_time <= NOW() AND status = 'active'";
	        PreparedStatement pstmt = con.prepareStatement(query);
	        ResultSet rs = pstmt.executeQuery();

	        while (rs.next()) {
	            int itemId = rs.getInt("id");
	            closeAuction(itemId);
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    } finally {
	        if (con != null) {
	            db.closeConnection(con);
	        }
	    }
	}
	
	
	public static void main(String[] args) {
		ApplicationDB dao = new ApplicationDB();
		Connection connection = dao.getConnection();
		
		System.out.println(connection);		
		dao.closeConnection(connection);
	}
	
	

}
