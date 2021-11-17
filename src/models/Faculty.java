package models;

public class Faculty extends User {
  private String password;
  private int buildingNumber;
  private int officeNumber;

  public String getPassword() { return password; }
  public void setPassword(String password) { this.password = password; }

  public int getBuildingNumber() { return buildingNumber; }
  public void setBuildingNumber(int buildingNumber) { this.buildingNumber = buildingNumber; }

  public int getOfficeNumber() { return officeNumber; }
  public void setOfficeNumber(int officeNumber) { this.officeNumber = officeNumber; }

  public Faculty(int userID, String firstName, String lastName, String email, int buildNumber, int officeNumber) {
    super(userID, firstName, lastName, email);
    this.buildingNumber = buildNumber;
    this.officeNumber = officeNumber;
  }

  public Faculty() { }
}
