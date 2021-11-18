import java.sql.*;
import java.util.*;
import models.*;
import services.File;

public class DataLayer {

  private Connection conn;
  public User user;
  public List<Abstract> abstracts;
  /* JDBC Type 4 Driver */
  static final String DEFAULT_DRIVER = "com.mysql.cj.jdbc.Driver";
  static final String DATABASE_NAME = "facultyresearch";

  private Statement stmt;
  private ResultSet rs;

  public boolean insertAbstract(int facultyID, 
                                String title, 
                                String content, 
                                String firstAuthorFirstName, 
                                String firstAuthorLastName, 
                                String secondAuthorFirstName, 
                                String secondAuthorLastName
  ) {
    try {
      conn.setAutoCommit(false);
      CallableStatement calledStmt = conn.prepareCall("{ CALL insertAbstractWithAuthors(?, ? ,? ,? ,? ,? ,?) }");
      calledStmt.setInt(1, facultyID);
      calledStmt.setString(2, title);
      calledStmt.setString(3, content);
      calledStmt.setString(4, firstAuthorFirstName);
      calledStmt.setString(5, firstAuthorLastName);
      calledStmt.setString(6, secondAuthorFirstName);
      calledStmt.setString(7, secondAuthorLastName);
      calledStmt.executeQuery();
      
      conn.commit();
      conn.setAutoCommit(true);

      return true;
    }
    catch (Exception ex) {
      ex.printStackTrace();
      try {
        conn.rollback();
        conn.setAutoCommit(true); 
      }      
      catch (SQLException sqlEx) {
        sqlEx.printStackTrace();
      }      
    }
    return false;   
  }

  public boolean checkLog(String email, String password) {
    // String sql = "SELECT * FROM user JOIN faculty USING(UserID) WHERE UserType =
    // 0 AND Email = '"+email+"' AND Password = '"+password+"';";
    String sql = "SELECT * FROM user JOIN faculty USING(UserID) WHERE UserType = 0 AND Email = 'lw533@g.rit.edu' AND Password = 's1v$c86gjil';";
    return executeLog(sql, "professor");
  }

  public boolean checkLog(String email) {
    String sql = "SELECT * FROM user JOIN student USING(UserID) WHERE Email = '" + email + "';";
    return executeLog(sql, "student");
  }

  public boolean executeLog(String sqlStatement, String userType) {
    try {
      conn.setAutoCommit(false);
      stmt = conn.createStatement();
      rs = stmt.executeQuery(sqlStatement);
      while (rs.next()) {
        if (userType.equals("professor"))
          user = new Faculty(rs.getInt("UserID"), rs.getString("FirstName"), rs.getString("LastName"),
              rs.getString("Email"), rs.getInt("BuildingNumber"), rs.getInt("OfficeNumber"));
        else if (userType.equals("student"))
          user = new Student(rs.getInt("UserID"), rs.getString("FirstName"), rs.getString("LastName"),
              rs.getString("Email"));
        break;
      }
      conn.setAutoCommit(true);
      if (rs.getRow() == 1)
        return true;
      else
        return false;
    } catch (Exception ex) {
      System.err.println(ex.getLocalizedMessage());
      try {
        conn.rollback();
        conn.setAutoCommit(true);
      } catch (SQLException ex2) {
        ex2.printStackTrace();
      }
      return false;
    }
  }

  public boolean canSearchAbstracts() {
    if (abstracts.size() > 0)
      return true;
    else
      return false;
  }

  public int viewAbstracts() {
    return 0;
  }

  public int searchProfessors(List<String> keywords) {
    return 0;
  }

  public void loadAbstracts(File file) {
    abstracts = new LinkedList<Abstract>();
    try {
      conn.setAutoCommit(false);
      stmt = conn.createStatement();
      rs = stmt.executeQuery("SELECT * FROM abstract;");
      String description = new String();
      while (rs.next()) {
        description = file.read(rs.getString("FileName"));
        abstracts.add(new Abstract(rs.getInt("AbstractID"), rs.getString("Title"), description));
      }
      conn.setAutoCommit(true);
    } catch (Exception ex) {
      System.err.println(ex.getLocalizedMessage());
      try {
        conn.rollback();
        conn.setAutoCommit(true);
      } catch (SQLException ex2) {
        ex2.printStackTrace();
      }
    }
  }

  /**
   * Connect the database using the cached creds.
   *
   * @return False if failed, true if succeeded
   */
  public boolean connect(String password) {
    try {
      conn = DriverManager.getConnection("jdbc:mysql://localhost/" + DATABASE_NAME, "root", password);
      return true;
    } catch (SQLException sqle) {
      sqle.printStackTrace();
      return false;
    }
  }

  /**
   * Closes the existing database connection if there is one.
   *
   * @return False if failed, true if succeeded.
   */
  public boolean close() {
    try {
      if (!conn.isClosed()) {
        conn.close();
        return conn.isClosed();
      }
    } catch (Exception ex) {
      return false;
    }
    return true;
  }
}
