import java.sql.*;

import models.*;

public class DataLayer {
  private Connection conn;
  /* JDBC Type 4 Driver */
  static final String DEFAULT_DRIVER = "com.mysql.cj.jdbc.Driver";
  static final String DATABASE_NAME = "facultyresearch";

  PreparedStatement stmt;
  ResultSet result;

  public void insertProfessor(Faculty faculty) {
    try {
      // conn.setAutoCommit(false);
      // // Insert backing user
      // stmt = conn.prepareStatement("INSERT INTO User (FirstName, LastName, Email, UserType) VALUES (?, ?, ?, ?)");
      // stmt.setString(1, faculty.getFirstName());
      // stmt.setString(2, faculty.getLastName());
      // stmt.setString(3, faculty.getEmail());
      // stmt.setInt(4, User.UserType.FACULTY.ordinal());
      // int rows = stmt.executeUpdate(SQL);
      // result.next();
      // int id = result.getInt(1);
      // // Insert faculty
      // stmt = conn.prepareStatement("INSERT INTO professor VALUES(?, ?, ?, ?, ?)");
      // stmt.setInt(1, id);
      // stmt.setInt(2, faculty.getBuildingNumber());
      // stmt.setInt(3, faculty.getOfficeNumber());
      // stmt.setString(4, faculty.getPassword());
      
      // conn.setAutoCommit(true);
    }
    catch (Exception ex) {
      System.err.println("Failed to insert User->Faculty.");
      System.err.println(ex.getLocalizedMessage());
      try {
        conn.rollback();
        conn.setAutoCommit(true);
      }
      catch (SQLException ex2) {
        ex2.printStackTrace();
      }
    }
  }
  public void insertStudent(Student student) {
    try {
      // conn.setAutoCommit(false);
      // // Insert backing user
      // stmt = conn.prepareStatement("INSERT INTO User (FirstName, LastName, Email, UserType) VALUES (?, ?, ?, ?)");
      // stmt.setString(1, student.getFirstName());
      // stmt.setString(2, student.getLastName());
      // stmt.setString(3, student.getEmail());
      // stmt.setInt(4, User.UserType.STUDENT.ordinal());
      // int rows = stmt.executeUpdate(SQL);
      // result.next();
      // int id = result.getInt(1);
      // // Insert student
      
      // conn.setAutoCommit(true);
    }
    catch (Exception ex) {
      System.err.println("Failed to insert User->Student.");
      System.err.println(ex.getLocalizedMessage());
      try {
        conn.rollback();
        conn.setAutoCommit(true);
      }
      catch (SQLException ex2) {
        ex2.printStackTrace();
      }
    }
  }

  /**
   * Connect the database using the cached creds.
   * @return False if failed, true if succeeded
   */
  public boolean connect(String password) { 
    try {
			conn = DriverManager.getConnection(
        "jdbc:mysql://localhost/" + DATABASE_NAME,
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
