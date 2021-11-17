package models;

import java.util.*;

public class Abstract {
  private int abstractID;
  private String title;
  private String description;
  private List<Author> authors;

  public int getAbstractID() { return abstractID; }

  public String getTitle() { return title; }
  public void setTitle(String title) { this.title = title; }

  public String getDescription() { return description; }
  public void setDescription(String description) { this.description = description; }

  public List<Author> getAuthors() { return authors; }

  public Abstract(int abstractID, String title, String description, List<Author> authors) {
    this.abstractID = abstractID;
    this.title = title;
    this.description = description;
    this.authors = authors;
  }

  public Abstract(int abstractID, String title, String description) {
    this.abstractID = abstractID;
    this.title = title;
    this.description = description;
  }

  public Abstract() { }

  public String toString(){
    return "\n\033[0;33mTitle: "+getTitle()+
           "\nAuthor: " +
           "\nDescription: " + getDescription();
  }
}
