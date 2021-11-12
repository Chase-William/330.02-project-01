import models.Faculty;

public class App {
    public static void main(String[] args) throws Exception {
        System.out.println("Hello, World!");
        DataLayer layer = new DataLayer();
        layer.connect("Csharp304360283");
        layer.insertProfessor(new Faculty("Chase", "Roth", "cxr6988@g.rit.edu", 10, 20));
    }
}
