// Group 1: Austin Bernal, Chase Roth, Quoc Nhan, Rachel Miller, Sam Sit
// Group Project - ISTE-330

import java.util.*;
import models.*;

public class PresentationLayer {

   private DataLayer data;
   private Scanner scan;
   final String logMenu = "\nAre you a professor or student?\n1. Professor\n2. Student\n3. Guest\n4. Exit the program";
   final String studentMenu = "\nWhat would like you to do?\n1. Search professor(s) via interests\n2. Log out\n3. Exit the program";
   final String professorMenu = "\nWhat would you like to do?\n1. Add an abstract\n2. Display absracts\n3. Log out\n4. Exit the program";
   final String guestMenu = "\nWhat would you like to do?\n1. Search student(s) via keyword\n2. Log out\n3. Exit the program";

   public PresentationLayer(DataLayer data, Scanner scan) {
      this.data = data;
      this.scan = scan;
   }

   public void run() {

      if (data.connect()) {
         data.loadAbstracts();
         System.out.println("Welcome to FacultyResearch!");
         menu("login", "[1-4]", logMenu);
      }
   }

   public void logIn(String user) {
      if(user.equals("guest")){
         System.out.println("\nSuccessfully logged in as a guest!");
         menu("guest", "[1-3]", guestMenu);
      }
      else{
         String logSentence = "\nYou are logging in as a " + user + "\n\nPlease enter your email";
         if(user.equals("professor"))
            logSentence += " and password";
         System.out.println(logSentence);
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
               System.out.println("\nSuccessfully logged in.\nWelcome, " + data.user.getFirstName() + " " + data.user.getLastName() + "!");
            if (user.equals("professor"))
               menu("professor", "[1-4]", professorMenu);
            else if (user.equals("student"))
               menu("student", "[1-3]", studentMenu);
         } else
            System.out.println("\nThe email or password you entered is either incorrect or not in the system.");
      }
   }

   public void logOut() {
      System.out.println("\nSuccessfully logged out.");
      data.user = null;
      menu("login", "[1-4]", logMenu);
   }

   public void menu(String typeMenu, String regexCondition, String menuString) {
      while (true) {
         int input = getInput(regexCondition, menuString);
         if (input > 0) {
            switch (typeMenu) {
            case "login": logChoice(input); break;
            case "professor": professorChoice(input); break;
            case "student": studentChoice(input); break;
            case "guest": guestChoice(input); break;
            }
         } else
            System.out.println("\nYou have entered invalid input, please try again");
      }
   }

   public void logChoice(int input) {
      switch (input) {
      case 1: logIn("professor"); break;
      case 2: logIn("student"); break;
      case 3: logIn("guest"); break;
      case 4: exit(); break;
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

   public void guestChoice(int input) {
      switch (input) {
      case 1: searchStudent(); break;
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
      data.loadAbstracts();
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
               else if(Integer.parseInt(input) == 0){
                  System.out.println("\nYou have entered invalid input");
               }else
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
      boolean cancel = false;
      while(true){
         List<String> keywordList = new LinkedList<String>();
         for(int i = 0; i < 3; i++){
            System.out.print("#"+(i+1)+" interest: ");
            String input = scan.nextLine();
            if(input.toLowerCase().equals("cancel")) {
               cancel = true;
               break;
            }
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
            boolean hasProfessor = data.hasProfessors(keywordList);
            if(hasProfessor)
               break;
            else
               System.out.println("\nNo professor found, try again -- enter \"CANCEL\" to cancel search");
         }
         else{
            if(cancel)
               System.out.println("\nSearch cancelled.");
            else
               System.out.println("\nYou haven't entered a single interest.");
               break;
         }
      }
   }

   public void searchStudent() {
      System.out.print("\nEnter a keyword: ");
      String input = scan.nextLine();
      data.searchStudent(input);
   }

   public static void main(String[] args) throws Exception {
      PresentationLayer app = new PresentationLayer(new DataLayer(), new Scanner(System.in));
      app.run();
   }
}
