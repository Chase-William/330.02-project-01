package models;

public class Student extends User {
  public Student(int userID, String firstName, String lastName, String email) {
    super(userID, firstName, lastName, email);
  }

  public Student() { }
}
