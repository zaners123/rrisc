package net.datadeer;

import java.util.ArrayList;
import java.util.Collections;

/** A group of commands. This could be as simple as a macro, or as complex as the full assembly file*/
class CommandGroup extends Command {
    private final Command[] commands;

    public CommandGroup(Command[] commands) {
        this.commands = commands;
    }

    public static CommandGroup create(Command[] commands) {
        return new CommandGroup(commands);
    }

    public static CommandGroup create(String[] commands) {
        Command[] commandArr = new Command[commands.length];
        for (int i=0;i<commands.length;i++) {
            try {
                commandArr[i] = CommandFactory.create(commands[i]);
                if (commandArr[i] != null) commandArr[i].lineRaw = commands[i];
            } catch (RuntimeException re) {
                re.printStackTrace();
                throw new RuntimeException("Malformed Command '"+commands[i]+"'.");
            }
        }
        return new CommandGroup(commandArr);
    }

    @Override
    public Nibble[] toNibbles(LabelManager lm) {
        ArrayList<Nibble> ret = new ArrayList<>();
        for (Command c : commands) {
            if (c == null) continue;
            Collections.addAll(ret, c.toNibbles(lm));
        }
        return ret.toArray(new Nibble[]{});
    }

    public Command[] getCommands() {
        return commands;
    }

}
