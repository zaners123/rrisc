package net.datadeer;

import java.util.HashMap;

class LabelManager {
    private final HashMap<String,Integer> labels;

    private static final LabelManager LM_ZERO = new LabelManager(null);

    LabelManager(CommandGroup commands) {
        labels = extractLabelsFromCommandGroup(commands);
    }
    private static HashMap<String, Integer> extractLabelsFromCommandGroup(CommandGroup commands) {
        if (commands == null) return null;
        HashMap<String,Integer> labels = new HashMap<>();
        int address = 0;
        for (Command c : commands.getCommands()) {
            if (c instanceof CommandFactory.LabelCommand) {
                CommandFactory.LabelCommand label = (CommandFactory.LabelCommand) c;
                labels.put(label.getName(), address);
            }
            address += c.getNumBytes(LM_ZERO);
        }
        return labels;
    }

    boolean hasLabel(String name) {
        if (this == LM_ZERO) return true;
        return labels.containsKey(name);
    }

    int getLabel(String name) {
        if (this == LM_ZERO) return 0;
        return labels.get(name);
    }

    /**
     * @param str The input string to be converted to an int
     *            Can be a number: hex(0x5), int(5), bin(0b101)
     *            Can be a label
     * @return The integer from the parsed string
     * */
    int stringToNumber(String str) {
        //test for number
        try {
            return Util.constToNumber(str);
        } catch (NumberFormatException nfe) {
            //test for label
            if (hasLabel(str)) {
                return getLabel(str);
            }
            //exception
            throw new RuntimeException("Unknown Immediate \""+str+"\"");
        }
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        labels.forEach((name,addr) -> sb.append(Integer.toString(addr,16)).append(":\t").append(name).append('\n'));
        return sb.toString();
    }
}
