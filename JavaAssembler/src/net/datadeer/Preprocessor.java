package net.datadeer;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;

public class Preprocessor {



    /**@param line A raw line from the user
     * @return The input line, modified in these ways:
     *      - It is in lowercase
     *      - Semicolon comments are removed
     *      - It is trimmed of spaces
     * */
    public static String lineRemoveComments(String line) {
        int index = line.indexOf(';');
        if (index != -1) line = line.substring(0, index);
        line = line.strip().toLowerCase();
//        if (line.isEmpty()) return null;
        return line;
    }

    public static ArrayList<CommandLine> linesRemoveComments(ArrayList<CommandLine> lines) {

        //Clean lines
        for (CommandLine cl : lines) cl.line = lineRemoveComments(cl.lineRaw);
        return lines;
    }

    public static File runCPreprocessor(File filein) {
        File tmp;
        try {
            tmp = File.createTempFile("asm",null);
            String cmd = "gcc -E -P -x c "+filein.getAbsolutePath() + " -o "+tmp.getAbsolutePath();
            Process p = Runtime.getRuntime().exec(cmd);
            BufferedInputStream bos = new BufferedInputStream(p.getErrorStream());
            int size;
            byte[] buffer = new byte[1024];
            while ((size = bos.read(buffer)) != -1) System.out.write(buffer, 0, size);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
        return tmp;
    }

}
