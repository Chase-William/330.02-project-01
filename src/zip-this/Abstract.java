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
  public void setAuthors(List<Author> authors) { this.authors = authors; }

  public Abstract(int abstractID, String title, String description) {
    this.abstractID = abstractID;
    this.title = title;
    this.description = description;
  }

  public String getAuthorsString(){
    String authorString = "";
    for (Author a : authors)
      authorString += a.getFirstName() + " " + a.getLastName() + " | ";
    return authorString = authorString.substring(0, authorString.length() - 3);
  }

  public Abstract() { }

  public String toString(){
    return "\nTitle: " + getTitle() +
           "\nAuthor: " + getAuthorsString() +
           "\nDescription: " + getDescription();
  }
}
