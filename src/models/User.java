package models;

public class User {
  public enum UserType {
    PROFESSOR,
    STUDENT
  }

  private int userID;
  private String email;
  private String lastName;
  private String firstName;
  
  public int getUserID() { return userID; }

  public String getEmail() { return email; }
  public void setEmail(String email) { this.email = email; }

  public String getLastName() { return lastName; }
  public void setLastName(String lastName) { this.lastName = lastName; }

  public String getFirstName() { return firstName; }
  public void setFirstName(String firstName) { this.firstName = firstName; }
  
  protected User(String firstName, String lastName, String email) { 
    this.firstName = firstName;
    this.lastName = lastName;
    this.email = email;  
  }

  protected User() { }

  /**
   * Creates a new instance of a { Professor, Student } type using the @param type.
   * @param type Discriminator which declares which sub type to create.
   * @param firstName
   * @param lastName
   * @param email
   * @return
   */
  public static User from(UserType type, String firstName, String lastName, String email) { 
    if (type.equals(UserType.PROFESSOR))
      return new Professor(firstName, lastName, email);
    return new Student(firstName, lastName, email);
  }
}
