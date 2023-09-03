package net.datadeer;

import java.io.*;
import java.util.ArrayList;
import java.util.Scanner;


public class Assembler {

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



    public static void main(String[] args) {
//        File filein = new File("asm/test_prepreocessor.asm");
        String name = "test_all";
        File filein = new File("asm/"+name+".asm");

        File c = Preprocessor.runCPreprocessor(filein);

        ArrayList<String> lines = fetchLinesFromFile(c.getAbsolutePath());
        Preprocessor.linesRemoveComments(lines);
        CommandFactory.CommandGroup commands = CommandFactory.CommandGroup.create(lines.toArray(new String[]{}));
        commandsPrint(commands);
        commandsToHexfile(filein+".hex", commands);
        commandsToCArrayFile("ArduinoProgrammer/hex.h", commands, name);
        System.out.println("Done");
    }

    private static void commandsPrint(CommandFactory.CommandGroup commands) {
        int loc = 0;
        for (Command c : commands.getCommands()) {
            if (c==null) continue;
            StringBuilder cdata = new StringBuilder();
            for (Nibble n : c.toNibbles()) cdata.append(n.toChar());
            System.out.printf("%04x:%-10s%s\n",loc,cdata,c.getLineRaw());
            loc += c.getNumBytes();
        }
    }

    /** Put the commands into a file
     * @param filename File to put commands in
     * @param commands A list of commands (AKA a program)
     */
    private static void commandsToHexfile(String filename, CommandFactory.CommandGroup commands) {
        try (FileWriter fw = new FileWriter(filename)) {
            String file = commandsToHexdata(commands);
            System.out.println("File data: "+file);
            fw.write(file);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }

    /** Take a series of commands and make it into a file
     * @param commands A list of commands
     * @return A string corresponding to a "v3.0 hex bytes plain big-endian" hex file
     */
    private static String commandsToHexdata(CommandFactory.CommandGroup commands) {
        StringBuilder sb = new StringBuilder();
        sb.append("v3.0 hex bytes plain big-endian\r");
        for (Nibble n : commands.toNibbles()) sb.append(n.toChar());
        return sb.toString();
    }

    /** Put the commands into a file
     * @param filename File to put commands in
     * @param commands A list of commands (AKA a program)
     */
    private static void commandsToCArrayFile(String filename, CommandFactory.CommandGroup commands, String name) {
        try (FileWriter fw = new FileWriter(filename)) {
            String file = commandsToCHexArray(commands, name);
            System.out.println("File data: "+file);
            fw.write(file);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }

    /** Take a series of commands and make it into a file
     * @param commands A list of commands
     * @return A string corresponding to a "C array readable by the arduino programmer" hex file
     */
    private static String commandsToCHexArray(CommandFactory.CommandGroup commands, String name) {
        StringBuilder sb = new StringBuilder();
        sb.append("const uint8_t PROG[] PROGMEM = {\n\t");
        for (Command c : commands.getCommands()) {
            if (c==null) continue;
            StringBuilder cdata = new StringBuilder();
            Nibble[] nibbles = c.toNibbles();
            for (int i=0;i<nibbles.length;i+=2) {
                cdata.append("0x");
                cdata.append(nibbles[i].toChar());
                cdata.append(nibbles[i+1].toChar());
                cdata.append(", ");
            }
            sb.append(cdata);
        }
        sb.append("\n};\n");
        sb.append("#define PROGNAME \"").append(name).append("\"\n");
        sb.append("#define PROGSIZE ").append(commands.getNumBytes()).append("\n");

        return sb.toString();
    }
}
