package net.datadeer;

import java.util.function.BiFunction;

import static net.datadeer.CommandFactory.OPCODE.*;
import static net.datadeer.CommandFactory.REGISTER.*;

public class Macro extends Command {
    private final MacroTemplate template;
    private final String postspace;

    public Macro(String prespace, String postspace) {
        this.template = MacroTemplate.getMacroTemplate(prespace);
        this.postspace = postspace;
    }
    private static class MacroTemplate {
        final static MacroTemplate[] MACROS = {
                new MacroTemplate("addi8", (lm, a) -> CommandGroup.create(new String[]{
                        "set RAT", "clr", "ori " + (lm.stringToNumber(a) % 16), "ori " + (lm.stringToNumber(a) / 16), "add RAT"
                })),
                new MacroTemplate("nop", (lm, a) -> new CommandFactory.OpcodeCommand(AND, ACC)),
                new MacroTemplate("clr", (lm, a) -> new CommandFactory.OpcodeCommand(XOR, ACC)),
                new MacroTemplate("setml", (lm, a) -> CommandGroup.create(new String[]{
                        "set RAT",
                        "clr", "xori " + (lm.stringToNumber(a) / 256) % 16, "xori " + (lm.stringToNumber(a) / 4096) % 16, "set RMH",
                        "clr", "xori " + (lm.stringToNumber(a) % 16), "xori " + (lm.stringToNumber(a) / 16) % 16, "set RML",
                        "get RAT"
                })),
                new MacroTemplate("setsl", (lm, a) -> CommandGroup.create(new String[]{
                        "set RAT",
                        "clr", "xori " + (lm.stringToNumber(a) / 256) % 16, "xori " + (lm.stringToNumber(a) / 4096) % 16, "set RSH",
                        "clr", "xori " + (lm.stringToNumber(a) % 16), "xori " + (lm.stringToNumber(a) / 16) % 16, "set RSL",
                        "get RAT"
                })),
                new MacroTemplate("push", (lm, a) -> CommandGroup.create(new String[]{
                        "set RAT",
                        "incsp",
                        "wb RAT",
                        "get RAT"
                })),
                new MacroTemplate("incsp", (lm, a) -> CommandGroup.create(new String[]{
                        "get RSL", "addi 1", "set RML", "set RSL",
                        "get RSH", "addict 1", "set RMH", "set RSH"
                })),
                new MacroTemplate("push", (lm, a) -> CommandGroup.create(new String[]{
                        "set RAT",
                        "incsp",
                        "wb RAT", "get RAT"
                })),
        };
        private final String name;
        private final BiFunction<LabelManager, String, Command> argToMacro;

        private MacroTemplate(String name, BiFunction<LabelManager, String, Command> argToMacro) {
            this.name = name;
            this.argToMacro = argToMacro;
        }

        protected String getName() {
            return name;
        }

        protected Command generateCommand(LabelManager lm, String args) {
            return argToMacro.apply(lm, args);
        }

        protected static MacroTemplate getMacroTemplate(String name) {
            for (MacroTemplate m : MacroTemplate.MACROS) {
                if (name.equals(m.getName())) return m;
            }
            return null;
        }
    }

    public static boolean doesMacroTemplateExist(String name) {
        return MacroTemplate.getMacroTemplate(name) != null;
    }

    @Override
    public Nibble[] toNibbles(LabelManager lm) {
        return template.generateCommand(lm,postspace).toNibbles(lm);
    }

}
