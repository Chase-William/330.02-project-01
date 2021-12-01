// Group 1: Austin Bernal, Chase Roth, Quoc Nhan, Rachel Miller, Sam Sit
// Group Project - ISTE-330

import java.io.*;
import java.sql.*;
import java.util.*;
import models.*;

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
                                String description,
                                String firstAuthorFirstName,
                                String firstAuthorLastName,
                                String secondAuthorFirstName,
                                String secondAuthorLastName
  ) {
    try {
      conn.setAutoCommit(false);
      CallableStatement calledStmt = conn.prepareCall("{ CALL insertAbstractWithAuthors(?, ? ,? ,? ,? ,?) }");
      calledStmt.setInt(1, facultyID);
      calledStmt.setString(2, title);
      calledStmt.setString(3, firstAuthorFirstName);
      calledStmt.setString(4, firstAuthorLastName);
      calledStmt.setString(5, secondAuthorFirstName);
      calledStmt.setString(6, secondAuthorLastName);
      calledStmt.executeQuery();

      conn.commit();
      conn.setAutoCommit(true);

      BufferedWriter writer = new BufferedWriter(new FileWriter("data/"+getFileNameOfNewAbstract(title, firstAuthorFirstName)+".txt"));
      writer.write(description);
      writer.close();
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

  public String getFileNameOfNewAbstract(String title, String firstAuthorFirstName){
      String fileName = new String();
      String sql = "SELECT * FROM abstract JOIN authorAbstract USING(AbstractID) JOIN Author USING(AuthorID) WHERE Title = '"+title+"' AND FirstName = '"+firstAuthorFirstName+"';";
      try {
        stmt = conn.createStatement();
        rs = stmt.executeQuery(sql);
        while (rs.next()) {
          return rs.getString("FileName");
        }
        return fileName;
      } catch (Exception ex) {
        System.err.println(ex.getLocalizedMessage());
        return "";
      }
  }

  public boolean checkLog(String email, String password) {
    String sql = "SELECT * FROM user JOIN faculty USING(UserID) WHERE UserType = 0 AND Email = '"+email+"' AND Password = '"+password+"';";
    // String sql = "SELECT * FROM user JOIN faculty USING(UserID) WHERE UserType = 0 AND Email = 'lw533@g.rit.edu' AND Password = 's1v$c86gjil';";
    return executeLog(sql, "professor");
  }

  public boolean checkLog(String email) {
    String sql = "SELECT * FROM user JOIN student USING(UserID) WHERE Email = '" + email + "';";
    // String sql = "SELECT * FROM user JOIN student USING(UserID) WHERE Email = 'rs404@g.rit.edu';";
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

  public boolean hasProfessors(List<String> keywords) {
    String sql = "SELECT * FROM UserAbstract JOIN Abstract USING(AbstractID) WHERE";
    List<Integer> facultyIds = new ArrayList<Integer>();
    for(String word : keywords)
      sql += " title LIKE '%"+word+"%' OR";
      sql = sql.substring(0, sql.length() - 3);
      sql += ";";
    try {
      conn.setAutoCommit(false);
      stmt = conn.createStatement();
      rs = stmt.executeQuery(sql);
      while (rs.next())
      if(!facultyIds.contains(rs.getInt("UserID")))
        facultyIds.add(rs.getInt("UserID"));

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
    insertKeyword(keywords);
    if(facultyIds.size() > 0){
      displayProfessor(facultyIds);
      return true;
    }
    else
      return false;
  }

  public void displayProfessor(List<Integer> userIds){
    String sql = "SELECT * FROM user JOIN faculty USING(userID) WHERE";
    for(Integer id : userIds)
      sql += " userID ="+id+" OR";
      sql = sql.substring(0, sql.length() - 3);
      sql += ";";
    try {
      conn.setAutoCommit(false);
      stmt = conn.createStatement();
      rs = stmt.executeQuery(sql);
      System.out.println();
      while (rs.next())
        System.out.println(rs.getString("FirstName")+" "+rs.getString("LastName") + " | Building room - " + rs.getString("BuildingNumber") + " | Office room - " + rs.getString("OfficeNumber") + " | Email - " + rs.getString("Email"));

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

  public void insertKeyword(List<String> keywords){
    String sql = "{CALL insertKeywordWithStudent(?, ?)}";
    for(String word : keywords){
      try {
        conn.setAutoCommit(false);
        CallableStatement call = conn.prepareCall(sql);
        call.setInt(1, user.getUserID());
        call.setString(2, word);

        ResultSet rs = call.executeQuery();

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
  }

  public boolean searchStudent(String keyword){
    String sql = "SELECT * FROM StudentKeyword JOIN Keyword USING(KeywordID) WHERE name ='"+keyword+"'";
    List<Integer> studentIds = new ArrayList<Integer>();
    try {
      conn.setAutoCommit(false);
      stmt = conn.createStatement();
      rs = stmt.executeQuery(sql);
      while (rs.next())
        if(!studentIds.contains(rs.getInt("UserID")))
          studentIds.add(rs.getInt("UserID"));
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
    if(studentIds.size() > 0) {
      displayStudent(studentIds);
      return true;
    }
    return false;
  }

  public void displayStudent(List<Integer> userIds){
    String sql = "SELECT * FROM user JOIN student USING(userID) WHERE";
    for(Integer id : userIds)
      sql += " userID ="+id+" OR";
      sql = sql.substring(0, sql.length() - 3);
      sql += ";";
    try {
      conn.setAutoCommit(false);
      stmt = conn.createStatement();
      rs = stmt.executeQuery(sql);
      System.out.println();
      while (rs.next())
        System.out.println(rs.getString("FirstName")+" "+rs.getString("LastName") + " | Email - " + rs.getString("Email"));

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

  public void loadAbstracts() {
    abstracts = new LinkedList<Abstract>();
    try {
      conn.setAutoCommit(false);
      stmt = conn.createStatement();
      rs = stmt.executeQuery("SELECT * FROM abstract;");
      String description = new String();
      while (rs.next()) {
        description = read(rs.getString("FileName"));
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
    for (Abstract a : abstracts)
      a.setAuthors(getAuthors(a.getAbstractID()));
  }


  public List<Author> getAuthors(int abstractID){
    List<Author> authors = new LinkedList<Author>();
    try {
      conn.setAutoCommit(false);
      stmt = conn.createStatement();
      rs = stmt.executeQuery("SELECT * FROM abstract JOIN authorAbstract USING(AbstractID) JOIN Author USING(AuthorID) WHERE AbstractID = "+abstractID+";");
      while (rs.next()) {
        authors.add(new Author(rs.getString("FirstName"), rs.getString("LastName")));
      }
      conn.setAutoCommit(true);
    } catch (Exception ex) {
      try {
        conn.rollback();
        conn.setAutoCommit(true);
      } catch (SQLException ex2) {
        ex2.printStackTrace();
      }
    }
    return authors;
  }

  public String read(String fileName){
    String line;
    String description = new String();
    try (BufferedReader br = new BufferedReader(new FileReader("data/"+fileName+".txt"))) {
        while ((line = br.readLine()) != null) {
            description += line;
        }
    } catch (IOException ioe) {
        System.out.println("Error reading "+fileName+".txt");
        ioe.printStackTrace();
    }
    return description;
}

  /**
   * Connect the database using the cached creds.
   *
   * @return False if failed, true if succeeded
   */
  public boolean connect() {
    try {
	    Scanner scanner = new Scanner(System.in);
      System.out.print("Input database password for root user: ");
      String pass = scanner.nextLine();
      conn = DriverManager.getConnection("jdbc:mysql://localhost/" + DATABASE_NAME, "root", pass);
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
