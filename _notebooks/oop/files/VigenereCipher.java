import java.io.FileReader;
import java.io.BufferedReader;
import java.io.FileWriter;
import java.io.PrintWriter;
import java.io.IOException;
import grok.Input;

public class VigenereCipher {
    public static void main(String[] args) {
        final int N_CHARS = 26;
        final boolean CHAR_READ = false;
        final boolean SHIFT_READ = true;
        // array of character shifts, index offset from 'A'
        int[] shiftArr = new int[N_CHARS];

        // get user input for files
        String shiftFile = Input.readLine("Input name of shift file: ");
        String inputFile = Input.readLine("Input name of input file: ");
        String outputFile = Input.readLine("Input name of output file: ");

        // Open the files
        try (BufferedReader shifts = new BufferedReader(new FileReader(shiftFile));
             BufferedReader input = new BufferedReader(new FileReader(inputFile));
             PrintWriter output = new PrintWriter(new FileWriter(outputFile))) {
            // read shift values from shiftFile
            System.out.println("Collecting shift values.");
            boolean shiftState = CHAR_READ;
            String line;
            int shiftIndex = 0;
            while ((line = shifts.readLine()) != null) {
                if (shiftState == CHAR_READ) {
                    shiftIndex = line.toUpperCase().charAt(0) - 'A';
                } else if (shiftState == SHIFT_READ) {
                    int shiftVal = Integer.parseInt(line);
                    shiftArr[shiftIndex] = shiftVal;
                }
                shiftState = !shiftState;
            }
            System.out.println("Shift values input.");
            for (int i = 0; i < shiftArr.length; i++) {
                System.err.println(String.format("%c: %d", 'A' + i, shiftArr[i]));
            }
            System.out.println("Encrypting document.");
            // encrypt document and output
            while ((line = input.readLine()) != null) {
                line = line.replaceAll("[^a-zA-Z]", "");
                line = line.toUpperCase();
                // We're going to build a new String while converting
                String newline = "";
                // Now loop through all the characters and perform the shift
                for (int i = 0; i < line.length(); i++) {
                    char c = line.charAt(i);
                    // Compute the new character, make sure to "wrap" back to A
                    newline += (char)('A' + (c - 'A' + shiftArr[c-'A'])%N_CHARS);
                }
                // write line to file
                output.println(newline);
            }
            System.out.println("Encryption complete.");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}