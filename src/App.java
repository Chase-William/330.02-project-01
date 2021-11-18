// Group 1: Austin Bernal, Chase Roth, Quoc Nhan, Rachel Miller, Sam Sit
// Group Project - ISTE-330

import java.util.*;
import models.*;
import services.File;

public class App {

   private DataLayer data;
   private Scanner scan;
   final String logMenu = "\nAre you a professor or student?\n1. Professor\n2. Student\n3. Exit the program";
   final String studentMenu = "\nWhat would like you to do?\n1. Search professor(s) via interests\n2. Log out\n3. Exit the program";
   final String professorMenu = "\nWhat would you like to do?\n1. Add an abstract\n2. Display absracts\n3. Log out\n4. Exit the program";

   public App(DataLayer data, Scanner scan) {
      this.data = data;
      this.scan = scan;
   }

   public void run() {

      if (data.connect()) {
         data.loadAbstracts(new File());
         System.out.println("Welcome to FacultyResearch!");
         menu("login", "[1-3]", logMenu);
      }
   }

   public void logIn(String user) {
      System.out.println("\nYou are logging in as a " + user + "\n\nPlease enter your email and password");
      System.out.print("Email: ");
      String email = scan.nextLine();

      boolean isSuccess = false;

      if (user.equals("professor")) {
         System.out.print("Password: ");
         String password = scan.nextLine();
         isSuccess = data.checkLog(email, password);
      } else if (user.equals("student"))
         isSuccess = data.checkLog(email);

      if (isSuccess) {
         if (data.user != null)
            System.out.println("\nSuccessfully logged in.\nWelcome, " + data.user.getFirstName() + " "
                  + data.user.getLastName() + "!");
         if (user.equals("professor"))
            menu("professor", "[1-4]", professorMenu);
         else if (user.equals("student"))
            menu("student", "[1-3]", studentMenu);
      } else
         System.out.println("\nThe email or password you entered is either incorrect or not in the system.");
   }

   public void logOut() {
      System.out.println("\nSuccessfully logged out.");
      data.user = null;
      menu("login", "[1-3]", logMenu);
   }

   public void menu(String typeMenu, String regexCondition, String menuString) {
      while (true) {
         int input = getInput(regexCondition, menuString);
         if (input > 0) {
            switch (typeMenu) {
            case "login": logChoice(input); break;
            case "professor": professorChoice(input); break;
            case "student": studentChoice(input); break;
            }
         } else
            System.out.println("\nYou have entered invalid input, please try again");
      }
   }

   public void logChoice(int input) {
      switch (input) {
      case 1: logIn("professor"); break;
      case 2: logIn("student"); break;
      case 3: exit(); break;
      }
   }

   public void professorChoice(int input) {
      switch (input) {
      case 1: insertAbstract(); break;
      case 2: searchAbstracts(); break;
      case 3: logOut(); break;
      case 4: exit(); break;
      }
   }

   public void studentChoice(int input) {
      switch (input) {
      case 1: searchProfessors(); break;
      case 2: logOut(); break;
      case 3: exit(); break;
      }
   }

   public int getInput(String regexCondition, String menuString) {
      System.out.println(menuString);
      System.out.print("Option: ");
      String input = scan.nextLine();
      if (input.matches(regexCondition))
         return Integer.parseInt(input);
      return 0;
   }

   public void exit() {
      data.close();
      System.exit(0);
   }

   public void insertAbstract() {
      System.out.print("\nEntering an Abstract\nEnter Title: ");
      String title = scan.nextLine();
      System.out.print("Content of the Abstract: ");
      String content = scan.nextLine();
      System.out.print("First Name of the First Author: ");
      String firstAuthorFirstName = scan.nextLine();
      System.out.print("Last Name of the First Author: ");
      String firstAuthorLastName = scan.nextLine();
      System.out.print("First Name of the Second Author: ");
      String secondAuthorFirstName = scan.nextLine();
      System.out.print("Last Name of the Second Author: ");
      String secondAuthorLastName = scan.nextLine();
      if (data.insertAbstract(data.user.getUserID(), title, content, firstAuthorFirstName, firstAuthorLastName, secondAuthorFirstName, secondAuthorLastName)){
        System.out.println("Successfully Inserted the Abstract!");
      } else
        System.out.println("Failed to Insert the Abstract!");
   }

   public void searchAbstracts() {
      if (data.canSearchAbstracts()) {
         while (true) {
            int count = 1;
            System.out.println("\nEnter option to view abstract's detail\n" + count + ". Cancel searching");
            for (Abstract a : data.abstracts) {
               count++;
               System.out.println(count + ". " + (a.getTitle()));
            }
            System.out.print("Option: ");
            String input = scan.nextLine();
            if (tryParseInt(input)) {
               if (Integer.parseInt(input) > 1 && Integer.parseInt(input) <= count)
                  System.out.println(data.abstracts.get(Integer.parseInt(input) - 2).toString());
               else
                  break;
            } else
               System.out.println("\nYou have entered invalid input");
         }
      }
   }

   public boolean tryParseInt(String value) {
      try {
         Integer.parseInt(value);
         return true;
      } catch (NumberFormatException e) {
         return false;
      }
   }

   public void searchProfessors() {
      System.out.println("\n(You can enter as a blank to ignore the # interest and proceed the search)\nEnter an interest (up to 3)");
      List<String> keywordList = new LinkedList<String>();
      for(int i = 0; i < 3; i++){
         System.out.print("#"+(i+1)+" interest: ");
         String input = scan.nextLine();
         if(!input.equals(""))
            keywordList.add(input);
         else
            break;
      }
      if(keywordList.size() > 0){
         String output = "\nYou have entered";
         for(String s : keywordList){
            output += " | "+s;
         }
         System.out.println(output+" | ");
         data.searchProfessors(keywordList);
      }
      else
         System.out.println("\nYou haven't entered a single interest");
   }

   public static void main(String[] args) throws Exception {
      App app = new App(new DataLayer(), new Scanner(System.in));
      app.run();

      // Scanner scan = new Scanner(System.in);
      // DataLayer layer = new DataLayer();
      // layer.connect("Csharp304360283!");
      // //layer.insertProfessor(new Faculty("Chase", "Roth", "cxr6988@g.rit.edu", 10,
      // 20));

      // // Declare variable
      // int option;
      // String firstName;
      // String lastName;
      // String email;
      // int buildNumber;
      // int officeNumber;
      // String words;

      // // Request the user to choose between 1-3
      // System.out.println("Please enter (1-3) or exit");
      // System.out.println("1. Insert a Faculty");
      // System.out.println("2. Insert a Student");
      // System.out.println("3. Search Abstracts");
      // //System.out.println("4. Search for interests outside of school");
      // option = scan.nextInt();

      // /* Option 1 - Insert a Faculty
      // * Basic informations of the Faculty
      // * Answers the Abstract file name
      // */
      // if (option == 1){
      // System.out.print("Please type first name: ");
      // firstName = scan.nextLine();
      // System.out.print("Please type last name: ");
      // lastName = scan.nextLine();
      // System.out.print("Please type email: ");
      // email = scan.nextLine();
      // System.out.print("Please type Build Number: ");
      // buildNumber = scan.nextInt();
      // System.out.print("Please type Office Number: ");
      // officeNumber = scan.nextInt();
      // layer.insertProfessor(new Faculty(firstName, lastName, email, buildNumber,
      // officeNumber));
      // }
      // /* Option 2 - Insert a Student
      // * Basic informations of the Student
      // * Answers the number of topics s/he would like to research
      // */
      // else if (option == 2){
      // System.out.print("Please type first name: ");
      // firstName = scan.nextLine();
      // System.out.print("Please type last name: ");
      // lastName = scan.nextLine();
      // System.out.print("Please type email: ");
      // email = scan.nextLine();
      // //layer.insertStudent(new Student(firstName, lastName, email));
      // }
      // /* Option 3 - Search Abstracts
      // * Asks the student ID
      // * Display a list of faculty sorted by the most matching Abstracts to least
      // matching Abstracts
      // * Asks student which faculty would s/he like to meet and then show the
      // Faculty information
      // */
      // else if (option == 3){
      // System.out.print("Please type 1-3 words of topic that you want to research:
      // ");
      // words = scan.nextLine();
      // }
      // //else if (option == 4){
      // //System.out.print("Please type 1-3 words of topic that you want to research:
      // ");
      // //words = scan.nextLine();
      // //}
      // else {
      // System.out.println("Have a nice day!");
      // }
   }
}
