package net.datadeer;

import static net.datadeer.CommandFactory.OPCODE.*;

class CommandFactory {
    public static final OPCODE[] IMMEDIATE_OPCODES = new OPCODE[]{ADDI, SUBI, XORI, ANDI, ORI};
    public static final OPCODE[] REGISTER_OPCODES = new OPCODE[]{ADD, SUB, XOR, AND, OR, SET, GET,RB,WB};
    public static final OPCODE[] CONDITION_OPCODES = new OPCODE[]{S,J};

    private static final boolean ALLOW_MACROS = true;
    private static final boolean ALLOW_ANYTHING_CONDITIONALS = true;

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
        R6(0x7),

        RML(0x8),//memory/RAM
        RMH(0x9),//memory/RAM
        RJL(0xA),//jump/ROM
        RJH(0xB),//jump/ROM
        R7(0xC),
        R8(0xD),RSL(0xD), // No Hardware Stack, just a mnemonic
        R9(0xE),RSH(0xE), // No Hardware Stack, just a mnemonic
        R10(0xF),RAT(0xF);


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

        public Nibble[] toNibbles(LabelManager lm) {return new Nibble[]{op.getNibble(),arg};}
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
                    return new OpcodeCommand(o, Util.constToNibble(postspace));
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

    public static class LabelCommand extends Command {
        private final String name;

        LabelCommand(String name) {
            this.name = name;
        }
        @Override
        public Nibble[] toNibbles(LabelManager lm) {
            return new Nibble[0];
        }
        public String getName() {
            return name;
        }
    }

    public static Command create(String line) {

        int indexFirstSpace = line.indexOf(' ');
        String prespace =  indexFirstSpace==-1?line:line.substring(0, indexFirstSpace);
        String postspace = indexFirstSpace==-1?""  :line.substring(indexFirstSpace+1);

        //is command a simple opcode / immediate
        Command op = findOpcodeCommand(line);
        if (op != null) return op;

        //Is command a label
        if (line.endsWith(":")) {
            String labelName = line.substring(0,line.length()-1);
            return new LabelCommand(labelName);
        }

        //Command isn't an opcode, try a macro
        if (ALLOW_MACROS) {
            if (Macro.doesMacroTemplateExist(prespace)) {
                return new Macro(prespace,postspace);
            }
        }

        //Commands that end in condition codes
        if (ALLOW_ANYTHING_CONDITIONALS) for (CONDITION c : CONDITION.values()) {
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
