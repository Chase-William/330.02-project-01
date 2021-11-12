import java.sql.*;

import models.*;

public class DataLayer {
  private Connection conn;
  /* JDBC Type 4 Driver */
  static final String DEFAULT_DRIVER = "com.mysql.cj.jdbc.Driver";
  static final String DATABASE_NAME = "facultyresearch";

  public void insertProfessor(Faculty user) {
    try {
      PreparedStatement stmt = conn.prepareStatement("INSERT INTO professor VALUES(?, ?, ?, ?, ?)");
      stmt.setInt(1, id);
      stmt.setString(2, fName);
      stmt.setString(3, lName);
      stmt.setString(4, street);
      stmt.setString(5, zip);
      int quantityInserted = stmt.executeUpdate();     
      System.out.println("Number of rows inserted: " + quantityInserted);
    }
    catch (Exception ex) {
      System.out.println("Failed to insert Passenger.");
      System.out.println(ex.getLocalizedMessage());
    }
  }

  /**
   * Connect the database using the cached creds.
   * @return False if failed, true if succeeded
   */
  public boolean connect(String password) { 
    try {
			conn = DriverManager.getConnection(
        DATABASE_NAME,
        "root",
        password
      );
      return true;
		}
		catch(SQLException sqle) {
			sqle.printStackTrace();
      return false;
		}    
  }

  /**
   * Closes the existing database connection if there is one.
   * @return False if failed, true if succeeded.
   */
  public boolean close() {
    try {
      if (!conn.isClosed()) {
        conn.close();
        return conn.isClosed();
      }
    }
    catch (Exception ex) {      
      return false;
    }
    return true;
  }

}