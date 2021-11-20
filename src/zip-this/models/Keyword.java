package models;

public class Keyword{
   private int keywordID;
   private String text;

   public int getKeywordID() {return keywordID;}
   public void setKeywordID(int keywordID) {this.keywordID = keywordID;}

   public String getText() {return text;}
   public void setText(String text) {this.text = text;}

   public Keyword(int keywordID, String text) {
      this.keywordID = keywordID;
      this.text = text;
   }

   public Keyword() { }
}