/* Java program to determine filetype of an input file  */
import grok.Input;
import java.io.FileReader;
import java.io.BufferedReader;
import java.io.IOException;

public class DetermineFileType {
    public static void main(String[] args) {
        System.out.print("Input filename: ");
        String filename = Input.readLine();
        String[] languages = new String[]{"C", "Java", "Python"};
        String[][] keywords = new String[languages.length][];
        keywords[0] = new String[]{"#include", "#define", "->", ".h"};
        keywords[1] = new String[]{"public", "import", "new", "String"};
        keywords[2] = new String[]{"dict", "tuple", "#", "import"};

        int[] frequency = new int[languages.length];

        try (BufferedReader br = new BufferedReader(new FileReader(filename))) {
            String line;
            while ((line = br.readLine()) != null) {
                System.err.println(line);
                // count keywords in the line for each language
                for (int i = 0; i < languages.length; i++) {
                    for (String keyword : keywords[i]) {
                       if (line.contains(keyword)) {
                           frequency[i]++;
                           System.err.println(languages[i] + " keyword " + keyword + " found");
                       }
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        // find max value
        boolean tie = false;
        int maxIndex = 0;

        for (int i = 1; i < frequency.length; i++) {
            if (frequency[i] > frequency[maxIndex]) {
                tie = false;
                maxIndex = i;
            } else if (frequency[i] == frequency[maxIndex]) {
                tie = true;
            }
        }

        if (tie) {
            System.out.println("Can't decide what language " + filename + " was written in...");
        } else {
            System.out.println(filename + " was written in " + languages[maxIndex] + ".");
        }
    }
}