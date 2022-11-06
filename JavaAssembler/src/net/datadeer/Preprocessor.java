package net.datadeer;

import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.regex.Pattern;

public class Preprocessor {

    /**@param line A raw line from the user
     * @return The input line, modified in these ways:
     *      - It is in lowercase
     *      - Semicolon comments are removed
     *      - It is trimmed of spaces
     * */
    public static String cleanLine(String line) {
        int index = line.indexOf(';');
        if (index != -1) line = line.substring(0, index);
        line = line.strip().toLowerCase();
//        if (line.isEmpty()) return null;
        return line;
    }

    private static boolean isLineForPreprocessor(String line) {
        return line.endsWith(":") || line.startsWith("#");
    }

    private static HashMap<String,String> generatePreprocessorDefinitions(Collection<CommandLine> lines) {
        HashMap<String,String> definitions = new HashMap<>();
        int addr = 0;
        for (CommandLine cl : lines) {
            if (cl == null || cl.line.isEmpty()) continue;
            if (isLineForPreprocessor(cl.line)) {
                if (cl.line.endsWith(":")) {
                    definitions.put(cl.line.substring(0,cl.line.length()-1), String.valueOf(addr));
                } else if (cl.line.startsWith("#define ")) {
                    int firstspace = cl.line.indexOf(' ');
                    if (firstspace==-1) throw new RuntimeException("Malformed #define statement: "+cl);
                    definitions.put(cl.line.substring(8,firstspace), cl.line.substring(firstspace+1));
                }
            } else {
                try {
                    Command c = CommandFactory.create(cl.line);
                    if (c != null) addr += c.toNibbles().length/2;
                } catch (NumberFormatException nfe) {

                }
            }
        }
        return definitions;
    }

    public static ArrayList<CommandLine> preprocessLines(ArrayList<CommandLine> lines) {

        //Clean lines
        for (CommandLine cl : lines) cl.line = cleanLine(cl.lineRaw);

        //use all definitions
        HashMap<String, String> definitions = generatePreprocessorDefinitions(lines);
        ArrayList<CommandLine> ret = new ArrayList<>();
        Pattern eachWord = Pattern.compile("\\s+");
        for (CommandLine cl : lines) {
            StringBuilder sb = new StringBuilder();
            String[] parts = eachWord.split(cl.line);
            for (String part : parts) {
                String definition = definitions.get(part);
                if (definition != null) {
                    sb.append(definition);
                } else {
                    sb.append(part);
                }
                sb.append(' ');
            }
            sb.deleteCharAt(sb.length()-1);

            if (!isLineForPreprocessor(sb.toString())) {
                ret.add(new CommandLine(cl.lineRaw, sb.toString()));
            }
        }
        return ret;
    }

}
