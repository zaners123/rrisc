package net.datadeer;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.time.LocalDateTime;
import java.util.ArrayList;

import static net.datadeer.Util.fetchLinesFromFile;

public class Assembler {

    public static void main(String[] args) {
        String name = "test_all";
        File filein = new File("asm/"+name+".asm");

        File c = Preprocessor.runCPreprocessor(filein);

        ArrayList<String> lines = fetchLinesFromFile(c.getAbsolutePath());
        Preprocessor.linesRemoveComments(lines);

        // Generate Command Group
        CommandGroup commands = CommandGroup.create(lines.toArray(new String[]{}));

        // Calculate label address offsets
        LabelManager lm = new LabelManager(commands);

        System.out.printf("Label Manager:\n"+ lm);

        // Print output in a bunch of formats
        commandsPrint(lm, commands);
        commandsToHexfile(lm, filein+".hex", commands);
        commandsToCArrayFile(lm, commands, "ArduinoProgrammer/hex.h", name);
        System.out.println("Done");
    }

    private static void commandsPrint(LabelManager lm, CommandGroup commands) {
        int loc = 0;
        for (Command c : commands.getCommands()) {
            if (c==null) continue;
            StringBuilder cdata = new StringBuilder();
            for (Nibble n : c.toNibbles(lm)) cdata.append(n.toChar());
            System.out.printf("%04x:%-10s%s\n",loc,cdata,c.getLineRaw());
            loc += c.getNumBytes(lm);
        }
    }

    /** Put the commands into a file
     * @param filename File to put commands in
     * @param commands A list of commands (AKA a program)
     */
    private static void commandsToHexfile(LabelManager lm, String filename, CommandGroup commands) {
        try (FileWriter fw = new FileWriter(filename)) {
            String file = commandsToHexdata(lm, commands);
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
    private static String commandsToHexdata(LabelManager lm, CommandGroup commands) {
        StringBuilder sb = new StringBuilder();
        sb.append("v3.0 hex bytes plain big-endian\r");
        for (Nibble n : commands.toNibbles(lm)) sb.append(n.toChar());
        return sb.toString();
    }

    /**
     * Put the commands into a file
     *
     * @param lm The LabelManager to get label addresses from
     * @param commands A list of commands (AKA a program)
     * @param filename File to put commands in
     */
    private static void commandsToCArrayFile(LabelManager lm, CommandGroup commands, String filename, String name) {
        try (FileWriter fw = new FileWriter(filename)) {
            String file = commandsToCHexArray(lm, commands, name);
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
    private static String commandsToCHexArray(LabelManager lm, CommandGroup commands, String name) {
        StringBuilder sb = new StringBuilder();
        sb.append("const uint8_t PROG[] PROGMEM = {\n\t");
        for (Command c : commands.getCommands()) {
            if (c==null) continue;
            StringBuilder cdata = new StringBuilder();
            Nibble[] nibbles = c.toNibbles(lm);
            for (int i=0;i<nibbles.length;i+=2) {
                cdata.append("0x");
                //The hardware storage is {IMM[3:0],OPCODE[3:0]}, so it flips here
                cdata.append(nibbles[i+1].toChar());
                cdata.append(nibbles[i].toChar());
                cdata.append(", ");
            }
            sb.append(cdata);
        }
        sb.append("\n};\n");
        LocalDateTime now = LocalDateTime.now();
        sb.append("#define PROGNAME \"").append(name).append(now.getHour()).append(":").append(now.getMinute()).append("\"\n");
        sb.append("#define PROGSIZE ").append(commands.getNumBytes(lm)).append("\n");

        return sb.toString();
    }
}
