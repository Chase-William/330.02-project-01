package services;

import java.io.*;

public class File{
    public File(){ }

    public String read(String fileName){
        String line;
        String description = new String();
        try (BufferedReader br = new BufferedReader(new FileReader("data/abstracts/"+fileName+".txt"))) {
            while ((line = br.readLine()) != null) {
                description += line;
            }
        } catch (IOException ioe) {
            System.out.println("Error reading "+fileName+".txt");
            ioe.printStackTrace();
        }
        return description;
    }
}