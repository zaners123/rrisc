package net.datadeer;

import java.io.*;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Scanner;


public class Assembler {

    /** Get every line from a file
     * @param filename The file read
     * @returns An array of its lines
     */
    static ArrayList<CommandLine> fetchLinesFromFile(String filename) {
        ArrayList<CommandLine> lines = new ArrayList<>();
        try {
            FileReader fr = new FileReader(filename);
            Scanner s = new Scanner(fr);
            while (s.hasNextLine()) lines.add(new CommandLine(s.nextLine(), null));
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        }
        return lines;
    }



    public static void main(String[] args) {
//        File filein = new File("asm/test_prepreocessor.asm");
        File filein = new File("asm/test_segdisplay.asm");

        File c = Preprocessor.runCPreprocessor(filein);

        ArrayList<CommandLine> lines = fetchLinesFromFile(c.getAbsolutePath());

        lines = Preprocessor.linesRemoveComments(lines);

        ArrayList<Command> commands = linesToCommands(lines);
        commandsToHexfile(filein+".hex", commands);

        System.out.println("Done");
    }

    /** Put the commands into a file
     * @param filename File to put commands in
     * @param commands A list of commands (AKA a program)
     */
    private static void commandsToHexfile(String filename, Collection<Command> commands) {
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
    private static String commandsToHexdata(Collection<Command> commands) {
        StringBuilder sb = new StringBuilder();
        sb.append("v3.0 hex bytes plain big-endian\r");
        int loc = 0;
        for (Command c : commands) {
            StringBuilder cdata = new StringBuilder();
            for (Nibble n : c.toNibbles()) {
                cdata.append((char) ((n.nibble>=10?'A'-10:'0') + n.nibble));
            }
            System.out.printf("%04x:%-10s%s\n",loc,cdata,c.getLineRaw());
            sb.append(cdata);
            loc += c.toNibbles().length/2;
        }
        return sb.toString();
    }

    /**
     * @param lines An array of lines of code
     * @returns A list of commands
     */
    private static ArrayList<Command> linesToCommands(ArrayList<CommandLine> lines) {
        ArrayList<Command> commands = new ArrayList<>();
        for (CommandLine cl : lines) {
            Command c = CommandFactory.create(cl.line);
            if (c != null) {
                c.cl = cl;
                commands.add(c);
            } else if (!cl.line.isEmpty()){
                System.err.println("Command Unknown: '"+cl.line+"' from '"+cl.lineRaw+"'");
            }
        }
        return commands;
    }
}
