package com.cs336.pkg;


import java.io.*;
import java.util.*;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.ScheduledFuture;
import java.util.concurrent.TimeUnit;
import java.sql.*;
import javax.servlet.http.*;
import javax.servlet.*;

import java.util.Date;
 

public class ScheduledTaskExample {
    private final ScheduledExecutorService scheduler = Executors
        .newScheduledThreadPool(1);

    public void startScheduleTask() {
    /**
    * not using the taskHandle returned here, but it can be used to cancel
    * the task, or check if it's done (for recurring tasks, that's not
    * going to be very useful)
    */
    @SuppressWarnings("unused")
	final ScheduledFuture<?> taskHandle = scheduler.scheduleAtFixedRate(
        new Runnable() {
            public void run() {
                try {
                    getDataFromDatabase();
                }catch(Exception ex) {
                    ex.printStackTrace(); //or loggger would be better
                }
            }
        }, 0, 3, TimeUnit.MINUTES);
    }

    private void getDataFromDatabase() {
    	System.out.println("scheduled run");
        try {
        	ApplicationDB db = new ApplicationDB();	
    		Connection con = db.getConnection();
    		String str1 = "SELECT * FROM Computer_Auctions " ;
    		String str2 = "SELECT * FROM Cellphone_Auctions " ;
    		String str3 = "SELECT * FROM Headphone_Auctions " ;
    		
    		PreparedStatement stmt1 = con.prepareStatement(str1);
			ResultSet result1 = stmt1.executeQuery();
						//current time
			Timestamp timestamp1 = new Timestamp(new Date().getTime());		    
			while(result1.next()) {
				if(result1.getString("status").equals("open")) {
					Timestamp result_time = result1.getTimestamp("end_date_time");
				    if(timestamp1.after(result_time)) {
				    	String update_auction_status = "UPDATE Computer_Auctions SET status = \'closed\' WHERE auction_id = \'"
				    			+ result1.getString("auction_id") + "\'";
				    	PreparedStatement stmt4 = con.prepareStatement(update_auction_status);
				    	stmt4.executeUpdate();
				    	sendMessagetoWinner(con, result1.getString("auction_id"),result1.getInt("lower_bound"));
				    }
				}
			}
   
			PreparedStatement stmt2 = con.prepareStatement(str2);
			ResultSet result2 = stmt2.executeQuery();
			
			while(result2.next()) {
				if(result2.getString("status").equals("open")) {
					Timestamp result_time = result2.getTimestamp("end_date_time");
				    if(timestamp1.after(result_time)) {
				    	String update_auction_status = "UPDATE Cellphone_Auctions SET status = \'closed\' WHERE auction_id = \'"
				    			+ result2.getString("auction_id") + "\'";
				    	PreparedStatement stmt4 = con.prepareStatement(update_auction_status);
				    	stmt4.executeUpdate();
				    	sendMessagetoWinner(con, result2.getString("auction_id"),result2.getInt("lower_bound"));
				    }
				}

			}
			
			PreparedStatement stmt3 = con.prepareStatement(str3);
			ResultSet result3 = stmt3.executeQuery();
			
			while(result3.next()) {
				if(result3.getString("status").equals("open")) {
					Timestamp result_time = result3.getTimestamp("end_date_time");
				    if(timestamp1.after(result_time)) {
				    	String update_auction_status = "UPDATE Headphone_Auctions SET status = \'closed\' WHERE auction_id = \'"
				    			+ result3.getString("auction_id") + "\'";
				    	PreparedStatement stmt4 = con.prepareStatement(update_auction_status);
				    	stmt4.executeUpdate();
				    	sendMessagetoWinner(con, result3.getString("auction_id"),result3.getInt("lower_bound"));
				    }	
				}
				
			}
			
			//send alert to bid winners
			
		    
			//close the connection.
			con.close();
			
        }catch(Exception ex) {
        	
        }
    }

    private void sendMessagetoWinner(Connection con, String aID, int reserve_price) {
    	try{
    		String highest_bidder = "SELECT * FROM Bids WHERE auction_id = \'" + aID 
        			+ "\' AND val = (SELECT MAX(val) FROM Bids WHERE auction_id =\'" + aID + "\')";
        	PreparedStatement ps1 = con.prepareStatement(highest_bidder);
        	ResultSet bidder_info = ps1.executeQuery();
        	if(bidder_info.next()) {
        		if(bidder_info.getInt("val")> reserve_price || reserve_price == 0) {
        			//Send Bid Alert
    				String alert = "INSERT INTO Notification( auction_id, user_id, message, message_date)" 
    				+ "VALUES (?, ?, ?, ?)"; 
    				
    				Timestamp alert_time = new Timestamp(new Date().getTime());	 
    				
    				//Create a Prepared SQL statement allowing you to introduce the parameters of the query
    				PreparedStatement ps2 = con.prepareStatement(alert);
    				
    				//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
    						ps2.setString(1, aID);
    						ps2.setString(2, bidder_info.getString("user_id"));
    						ps2.setString(3, "You won the bid!");
    						ps2.setTimestamp(4, alert_time);
    						//Run the query against the DB
    						ps2.executeUpdate();
        		}else {
        			//Send Bid Alert
    				String alert = "INSERT INTO Notification( auction_id, user_id, message, message_date)" 
    				+ "VALUES (?, ?, ?, ?)"; 
    				
    				Timestamp alert_time = new Timestamp(new Date().getTime());	 
    				
    				//Create a Prepared SQL statement allowing you to introduce the parameters of the query
    				PreparedStatement ps2 = con.prepareStatement(alert);
    				
    				//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
    						ps2.setString(1, aID);
    						ps2.setString(2, bidder_info.getString("user_id"));
    						ps2.setString(3, "You did not win the bid because you did not outbid the reserve price! Auction is now closed.");
    						ps2.setTimestamp(4, alert_time);
    						//Run the query against the DB
    						ps2.executeUpdate();
        		}
        	}
    	}catch(Exception ex) {
    		System.out.println(ex);
    	}
    	
    }

}