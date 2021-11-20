package models;

public class Author {
  private int authorID;
  private String firstName;
  private String lastName;

  public int getAuthorID() { return authorID; }

  public String getFirstName() { return firstName; }
  public void setFirstName(String firstName) { this.firstName = firstName; }

  public String getLastName() { return lastName; }
  public void setLastName(String lastName) { this.lastName = lastName; }

  public Author(String firstName, String lastName) {
    this.firstName = firstName;
    this.lastName = lastName;
  }

  public Author() { }
}