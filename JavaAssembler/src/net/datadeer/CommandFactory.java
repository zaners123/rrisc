package net.datadeer;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.regex.Pattern;

import static net.datadeer.CommandFactory.OPCODE.*;

class CommandFactory {
    public static final OPCODE[] IMMEDIATE_OPCODES = new OPCODE[]{ADDI, SUBI, XORI, ANDI, ORI};
    public static final OPCODE[] REGISTER_OPCODES = new OPCODE[]{ADD, SUB, XOR, AND, OR, SET, GET,RB,WB};
    public static final OPCODE[] CONDITION_OPCODES = new OPCODE[]{S,J};

    private static final boolean ALLOW_MACROS = false;

    enum OPCODE {
        ADD(0x0),ADDI(0x1),
        SUB(0x2),SUBI(0x3),
        S  (0x4),J   (0x5),
        XOR(0x6),XORI(0x7),
        AND(0x8),ANDI(0x9),
        SET(0xA),RB  (0xB),
        GET(0xC),WB  (0xD),
        OR (0xE),ORI (0xF);

        private final Nibble nibble;
        OPCODE(int hex) {this.nibble = new Nibble(hex);}
        public Nibble getNibble() {return nibble;}
    }
    enum CONDITION {
        NO(0x0),/*Never*/       AL(0x1),/*Always*/
        CO(0x2),/*CmpOdd*/    CE(0x3),/*CmpEven*/
        CN(0x4),/*CmpNeg*/    CP(0x5),/*CmpPos*/
        CNZ(0x6),/*CmpNonZero*/CZ(0x7),/*CmpZero*/
        AO(0x8),/*AccOdd*/      AE(0x9),/*AccEven*/
        AN(0xA),/*AccNeg*/      AP(0xB),/*AccPos*/
        NC(0xC),/*NEWCOND*/     NNC(0xD),/*not NEWCOND*/
        CT(0xE),/*CarryTrue*/  CF(0xF);/*CarryFalse*/

        private final Nibble nibble;
        CONDITION(int hex) {this.nibble = new Nibble(hex);}
        public Nibble getNibble() {return nibble;}
        public Nibble getInverseNibble() {return new Nibble(nibble.nibble ^ 1);}
    }
    enum REGISTER {
        //Following Motherboard Hardware Pinout
        ACC(0x0),R0(0x0),RAC(0x0),
        RCS(0x1),CMP(0x1),
        R1(0x2),
        R2(0x3),
        R3(0x4),
        R4(0x5),
        R5(0x6),
        R6(0x7),RSL(0x7), // No Hardware Stack, just a mnemonic
        R7(0x8),RSH(0x8), // No Hardware Stack, just a mnemonic

        RML(0x9),
        RMH(0xA),
        RROML(0xB),
        RROMH(0xC),
        R8(0xD),
        R9(0xE),RAT(0xE);


        private final Nibble nibble;

        REGISTER(int hex) {this.nibble = new Nibble(hex);}

        public Nibble getNibble() {
            return nibble;
        }

        public static REGISTER findRegisterArgument(String str) {
            for (REGISTER r : REGISTER.values()) {
                if (r.name().equalsIgnoreCase(str)) return r;
            }
            return null;
        }
    }

    static class OpcodeCommand extends Command {

        private final OPCODE op;
        private final Nibble arg;

        OpcodeCommand(OPCODE op, Nibble arg) {
            this.op = op;
            this.arg = arg;
        }
        OpcodeCommand(OPCODE op, REGISTER reg) {
            this(op, reg.getNibble());
        }

        public Nibble[] toNibbles() {return new Nibble[]{op.getNibble(),arg};}
    }

    /** A group of commands. This could be as simple as a macro, or as complex as the full assembly file*/
    protected static class CommandGroup extends Command {
        private final Command[] commands;
        private int address;

        public CommandGroup(Command[] commands, int address) {
            this.commands = commands;
            this.address = address;
        }

        public static CommandGroup create(Command[] commands) {
            return new CommandGroup(commands, 0);
        }

        public static CommandGroup create(String[] commands) {
            return create(commands, 0);
        }
        public static CommandGroup create(String[] commands, int address) {
            Command[] commandArr = new Command[commands.length];
            for (int i=0;i<commands.length;i++) {
                try {
                    commandArr[i] = CommandFactory.create(commands[i], address);
                    if (commandArr[i] != null) commandArr[i].lineRaw = commands[i];
                } catch (RuntimeException re) {
                    re.printStackTrace();
                    throw new RuntimeException("Malformed Command '"+commands[i]+"'.");
                }
                if (commandArr[i] != null) address += commandArr[i].getNumBytes();
            }
            return new CommandGroup(commandArr, address);
        }

        @Override
        public Nibble[] toNibbles() {
            ArrayList<Nibble> ret = new ArrayList<>();
            for (Command c : commands) {
                if (c == null) continue;
                Collections.addAll(ret, c.toNibbles());
            }
            return ret.toArray(new Nibble[]{});
        }

        public Command[] getCommands() {
            return commands;
        }

    }

    /**
     * @param str The input string to be converted to an int
     *            Can be a number: hex(0x5), int(5), bin(0b101)
     *            Can be a label
     * @return The integer from the parsed string
     * */
    static int stringToNumber(String str) {
        //test for number
        if (Pattern.matches("0x[0-9a-zA-Z]+", str)) return Integer.valueOf(str.substring(2),16);
        if (Pattern.matches("0b[01]+",str)) return Integer.valueOf(str.substring(2),2);
        if (Pattern.matches("[0-9]+",str)) return Integer.parseInt(str);
        //test for label
        if (LabelManager.hasLabel(str)) {
            return LabelManager.getLabel(str);
        }
        //exception
        throw new RuntimeException("Unknown Immediate \""+str+"\"");
    }

    static Nibble stringToNibble(String str) {
        int number = stringToNumber(str);
        if (number<0 || number>15) throw new RuntimeException("Immediate out of range 0<x<16: "+number);
        return new Nibble(number);
    }

    public static Command findOpcodeCommand(String line) {
        // Find Command
        int indexFirstSpace = line.indexOf(' ');
        String prespace =  indexFirstSpace==-1?line:line.substring(0, indexFirstSpace);
        String postspace = indexFirstSpace==-1?""  :line.substring(indexFirstSpace+1);

        if (indexFirstSpace != -1) {
            //Immediate ops "addi 5"
            for (OPCODE o : IMMEDIATE_OPCODES) {
                if (o.name().toLowerCase().equals(prespace)) {
                    return new OpcodeCommand(o, stringToNibble(postspace));
                }
            }
            //Register ops "add R3"
            for (OPCODE o : REGISTER_OPCODES) {
                if (o.name().equalsIgnoreCase(prespace)) {
                    REGISTER arg = REGISTER.findRegisterArgument(postspace);
                    if (arg==null) throw new RuntimeException("Unknown register '"+postspace+"'");
                    return new OpcodeCommand(o, arg.getNibble());
                }
            }
        } else {
            //Conditional "JAL"
            for (OPCODE o : CONDITION_OPCODES) {
                for (CONDITION c : CONDITION.values()) {
                    if (line.equalsIgnoreCase(o.name()+c.name())) {
                        return new OpcodeCommand(o, c.getNibble());
                    }
                }
            }
        }
        return null;
    }

    public static Command create(String line, int address) {

        int indexFirstSpace = line.indexOf(' ');
        String prespace =  indexFirstSpace==-1?line:line.substring(0, indexFirstSpace);
        String postspace = indexFirstSpace==-1?""  :line.substring(indexFirstSpace+1);

        //is command a simple opcode / immediate
        Command op = findOpcodeCommand(line);
        if (op != null) return op;

        //Is command a label
        if (line.endsWith(":")) {
            LabelManager.addLabel(line.substring(0,line.length()-1), address);
            return null;
        }

        //Command isn't an opcode, try a converted command
        if (ALLOW_MACROS) for (Macro m : Macro.MACROS) {
            if (prespace.equals(m.getName())) return m.getCommand(postspace);
        }

        //Commands that end in condition codes
        for (CONDITION c : CONDITION.values()) {
            if (prespace.endsWith(c.name().toLowerCase())) {
                //This is an inverted switch followed by an opcode command
                Command cmd = findOpcodeCommand(prespace.substring(0,prespace.length()-2)+" "+postspace);

                if (cmd != null) {
                    return CommandGroup.create(new Command[]{
                            new OpcodeCommand(S, c.getInverseNibble()),
                            cmd
                    });
                }
            }
        }

        //Command Unknown?
        throw new RuntimeException("Command Unknown: "+line);
    }
}
