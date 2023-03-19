package net.datadeer;

import java.util.function.Function;

import static net.datadeer.CommandFactory.OPCODE.*;
import static net.datadeer.CommandFactory.REGISTER.*;
import static net.datadeer.CommandFactory.stringToNumber;

public class Macro {
    final static Macro[] MACROS = {

            new Macro("addi8",(a) -> CommandFactory.CommandGroup.create(new String[]{
                    "set RAT", "clr", "ori "+(stringToNumber(a)%16),"ori "+(stringToNumber(a)/16), "add RAT"
            })),

            new Macro("nop",(a) -> new CommandFactory.OpcodeCommand(AND, ACC)),
            new Macro("clr",(a) -> new CommandFactory.OpcodeCommand(XOR, ACC)),

            new Macro("setml",(a) -> CommandFactory.CommandGroup.create(new String[]{
                    "set RAT",
                    "clr","xori "+(stringToNumber(a)/256)%16, "xori "+(stringToNumber(a)/4096)%16, "set RMH",
                    "clr","xori "+(stringToNumber(a)%16), "xori "+(stringToNumber(a)/16)%16, "set RML",
                    "get RAT"
            })),
            new Macro("setsl",(a) -> CommandFactory.CommandGroup.create(new String[]{
                    "set RAT",
                    "clr","xori "+(stringToNumber(a)/256)%16, "xori "+(stringToNumber(a)/4096)%16, "set RSH",
                    "clr","xori "+(stringToNumber(a)%16), "xori "+(stringToNumber(a)/16)%16, "set RSL",
                    "get RAT"
            })),

            new Macro("push",(a) -> CommandFactory.CommandGroup.create(new String[]{
                    "set RAT",
                    "incsp",
                    "wb RAT",
                    "get RAT"
            })),
            new Macro("incsp",(a) -> CommandFactory.CommandGroup.create(new String[]{
                    "get RSL", "addi 1", "set RML", "set RSL",
                    "get RSH", "addict 1", "set RMH", "set RSH"
            })),
            new Macro("push",(a) -> CommandFactory.CommandGroup.create(new String[]{
                    "set RAT",
                    "incsp",
                    "wb RAT", "get RAT"
            })),
    };
    private final String name;
    private final Function<String, Command> argToMacro;

    Macro(String name, Function<String, Command> argToMacro) {
        this.name = name;
        this.argToMacro = argToMacro;
    }

    public String getName() {
        return name;
    }

    public Command getCommand(String args) {
        return argToMacro.apply(args);
    }
}
