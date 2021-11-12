package models;

public class Abstract {
  private int abstractID;
  private String title;
  private String description;

  public int getAbstractID() { return abstractID; }

  public String getTitle() { return title; }
  public void setTitle(String title) { this.title = title; }

  public String getDescription() { return description; }
  public void setDescription(String description) { this.description = description; }

  public Abstract(int abstractID, String title, String description) {
    this.abstractID = abstractID;
    this.title = title;
    this.description = description;
  }

  public Abstract(String title, String description) {
    this.title = title;
    this.description = description;
  }

  public Abstract() { }
}
