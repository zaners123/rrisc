package net.datadeer;

import java.util.ArrayList;
import java.util.Collections;
import java.util.regex.Pattern;

import static net.datadeer.CommandFactory.OPCODE.*;

public class CommandFactory {
    public static final OPCODE[] IMMEDIATE_OPCODES = new OPCODE[]{ADDI, SUBI, XORI, ANDI, ORI};
    public static final OPCODE[] REGISTER_OPCODES = new OPCODE[]{ADD, SUB, XOR, AND, OR, SET, GET,RB,WB};
    public static final OPCODE[] CONDITION_OPCODES = new OPCODE[]{S,J};

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
        AL(0x0),MP(0x0),    NO(0x1),
        NZ(0x2),/*NotZero*/     EZ(0x3),/*EqualsZero*/
        OD(0x4),/*ODD*/         EV(0x5),/*Even*/
        POS(0x6),/*Positive*/   NEG(0x7),/*Negative*/
        CT(0xE),/*CarryTrue*/   CF(0xF);/*Carry False*/

        private final Nibble nibble;
        CONDITION(int hex) {this.nibble = new Nibble(hex);}
        public Nibble getNibble() {return nibble;}
        public Nibble getInverseNibble() {return new Nibble(nibble.nibble ^ 1);}
    }
    enum REGISTER {
        ACC(0x0),R0(0x0),RAC(0x0),
        R1(0x1),
        R2(0x2),
        R3(0x3),
        R4(0x4),
        R5(0x5),
        R6(0x6),
        R7(0x7),
        R8(0x8),
        R9(0x9),RAT(0x9),
        RSH(0xA),
        RSL(0xB),
        RCMP(0xC),CMP(0xC),
        RDST(0xD),DST(0xD),
        RMH(0xE),
        RML(0xF);

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

    static class CommandGroup extends Command {
        private final Command[] commands;

        CommandGroup(Command[] commands) {
            this.commands = commands;
        }

        public static CommandGroup create(String[] commands) {
            Command[] commandArr = new Command[commands.length];
            for (int i=0;i<commands.length;i++) {
                commandArr[i] = CommandFactory.create(commands[i]);
                if (commandArr[i] == null) throw new RuntimeException("Bad Command Group "+commands[i]);
            }
            return new CommandGroup(commandArr);
        }

        @Override
        public Nibble[] toNibbles() {
            ArrayList<Nibble> ret = new ArrayList<>();
            for (Command c : commands) {
                Collections.addAll(ret, c.toNibbles());
            }
            return ret.toArray(new Nibble[0]);
        }
    }

    /**Can do hex(0x5), int(5), bin(0b101)
     * @param str The input string to be converted to an int
     * @return The integer from the parsed string
     * */
    static int stringToNumber(String str) {
        if (Pattern.matches("0x[0-9a-zA-Z]+", str)) return Integer.valueOf(str.substring(2),16);
        if (Pattern.matches("0b[01]+",str)) return Integer.valueOf(str.substring(2),2);
        if (Pattern.matches("[0-9]+",str)) return Integer.parseInt(str);
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

    public static Command create(String line) {

        int indexFirstSpace = line.indexOf(' ');
        String prespace =  indexFirstSpace==-1?line:line.substring(0, indexFirstSpace);
        String postspace = indexFirstSpace==-1?""  :line.substring(indexFirstSpace+1);

        Command op = findOpcodeCommand(line);
        if (op != null) return op;

        //Command isn't an opcode, try a converted command
        for (Macro m : Macro.MACROS) {
            if (prespace.equals(m.getName())) return m.getCommand(postspace);
        }

        //Commands that end in condition codes
        for (CONDITION c : CONDITION.values()) {
            if (prespace.endsWith(c.name().toLowerCase())) {
                //This is a inverted switch followed by an opcode command
                Command cmd = findOpcodeCommand(prespace.substring(0,prespace.length()-2)+" "+postspace);

                if (cmd != null) {
                    return new CommandGroup(new Command[]{
                            new OpcodeCommand(S, c.getInverseNibble()),
                            cmd
                    });
                }
            }
        }

        //Command Unknown?
        return null;
    }
}
