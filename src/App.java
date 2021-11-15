import models.Faculty;
import java.util.*;

public class App {
    public static void main(String[] args) throws Exception {
      Scanner scan = new Scanner(System.in);
      System.out.println("Hello, World!");
      DataLayer layer = new DataLayer();
      layer.connect("Csharp304360283!");
      //layer.insertProfessor(new Faculty("Chase", "Roth", "cxr6988@g.rit.edu", 10, 20));
        
      // Declare variable 
      int option;
      String firstName;
      String lastName;
      String email;
      int buildNumber;
      int officeNumber;
      String words;
        
      // Request the user to choose between 1-3
      System.out.println("Please enter (1-3) or exit");
      System.out.println("1. Insert a Faculty");
      System.out.println("2. Insert a Student");
      System.out.println("3. Search Abstracts");
      //System.out.println("4. Search for interests outside of school");
      option = scan.nextInt();
      
      /* Option 1 - Insert a Faculty
       * Basic informations of the Faculty
       * Answers the Abstract file name
       */
      if (option == 1){
         System.out.print("Please type first name: ");
         firstName = scan.nextLine();
         System.out.print("Please type last name: ");
         lastName = scan.nextLine();
         System.out.print("Please type email: ");
         email = scan.nextLine();
         System.out.print("Please type Build Number: ");
         buildNumber = scan.nextInt();
         System.out.print("Please type Office Number: ");
         officeNumber = scan.nextInt();
         layer.insertProfessor(new Faculty(firstName, lastName, email, buildNumber, officeNumber));
      }
      /* Option 2 - Insert a Student
       * Basic informations of the Student
       * Answers the number of topics s/he would like to research
       */
      else if (option == 2){
         System.out.print("Please type first name: ");
         firstName = scan.nextLine();
         System.out.print("Please type last name: ");
         lastName = scan.nextLine();
         System.out.print("Please type email: ");
         email = scan.nextLine();
         //layer.insertStudent(new Student(firstName, lastName, email));
      }
      /* Option 3 - Search Abstracts
       * Asks the student ID
       * Display a list of faculty  sorted by the most matching Abstracts to least matching Abstracts
       * Asks student which faculty would s/he like to meet and then show the Faculty information
       */
      else if (option == 3){
         System.out.print("Please type 1-3 words of topic that you want to research: ");
         words = scan.nextLine();
      }
      //else if (option == 4){
         //System.out.print("Please type 1-3 words of topic that you want to research: ");
         //words = scan.nextLine();
      //}
      else {
         System.out.println("Have a nice day!");
      }
    }
}
