package net.datadeer;

import java.io.FileNotFoundException;
import java.io.FileReader;
import java.util.ArrayList;
import java.util.Scanner;
import java.util.regex.Pattern;

public class Util {

    static Nibble constToNibble(String str) {
        int number = constToNumber(str);
        if (number<0 || number>15) throw new RuntimeException("Immediate out of range 0<x<16: "+number);
        return new Nibble(number);
    }

    static Integer constToNumber(String str) {
        if (Pattern.matches("0x[0-9a-zA-Z]+", str)) return Integer.valueOf(str.substring(2),16);
        if (Pattern.matches("0b[01]+",str)) return Integer.valueOf(str.substring(2),2);
        if (Pattern.matches("[0-9]+",str)) return Integer.parseInt(str);
        throw new NumberFormatException(str+" not a number");
    }

    /** Get every line from a file
     * @param filename The file read
     * @returns An array of its lines
     */
    static ArrayList<String> fetchLinesFromFile(String filename) {
        ArrayList<String> lines = new ArrayList<>();
        try {
            FileReader fr = new FileReader(filename);
            Scanner s = new Scanner(fr);
            while (s.hasNextLine()) lines.add(s.nextLine());
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        }
        return lines;
    }

}
