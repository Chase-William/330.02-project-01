import java.sql.*;

public class DataLayer {
  private Connection conn;
  /* JDBC Type 4 Driver */
  static final String DEFAULT_DRIVER = "com.mysql.cj.jdbc.Driver";
  static final String DATABASE_NAME = "facultyresearch";

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