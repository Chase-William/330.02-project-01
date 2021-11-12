package models;

public class Professor extends User {
  private String password;
  private int buildingNumber;
  private int officeNumber;

  public String getPassword() { return password; }
  public void setPassword(String password) { this.password = password; } 

  public int getBuildingNumber() { return buildingNumber; }
  public void setBuildingNumber(int buildingNumber) { this.buildingNumber = buildingNumber; }

  public int getOfficeNumber() { return officeNumber; }
  public void setOfficeNumber(int officeNumber) { this.officeNumber = officeNumber; }

  public Professor(String firstName, String lastName, String email) {
    super(firstName, lastName, email);
  }

  public Professor() { }
}
