import math
import re
import sys

from pathlib import Path

conditionalOpcode = {
    "al": 0x0,
    "mp": 0x0,
    "no": 0x1,
    "nz": 0x2,
    "ez": 0x3,
    "lz": 0x4,
    "gz": 0x5,
    "lt": 0x6,
    "ge": 0x7,
    "eq": 0x8,
    "ne": 0x9,
    "gt": 0xA,
    "le": 0xB,
    "od": 0xC,
    "ev": 0xD,
    "ct": 0xE,
    "cf": 0xF,
}

actionNameToOpcode = {
    "addi": 0x0,
    "add": 0x1,
    "subi": 0x2,
    "sub": 0x3,
    "andi": 0x4,
    "and": 0x5,
    "get": 0x6,
    "set": 0x7,
    "ori": 0x8,
    "or": 0x9,
    "xori": 0xA,
    "xor": 0xB,
    "s": 0xC,
    "j": 0xD,
    "rb": 0xE,
    "wb": 0xF,
}

registers = {
    "r0": 0x0,
    "acc": 0x0,
    "rac": 0x0,

    "r1": 0x1,
    "r2": 0x2,
    "r3": 0x3,
    "r4": 0x4,
    "r5": 0x5,
    "r6": 0x6,
    "r7": 0x7,
    "r8": 0x8,

    "r9": 0x9,
    "rat": 0x9,

    "r10": 0xA,
    "ra": 0xA,
    "cmp": 0xA,
    "rcs": 0xA,

    "r11": 0xB,
    "rb": 0xB,
    "dst": 0xB,
    "rcd": 0xB,

    "r12": 0xC,
    "rc": 0xC,
    "rsh": 0xC,

    "rsl": 0xD,
    "r13": 0xD,
    "rd": 0xD,

    "rmh": 0xE,
    "r14": 0xE,
    "re": 0xE,
    "rml": 0xF,
    "r15": 0xF,
    "rf": 0xF,
}

conditionalRegex = ('|'.join(str(x) for x in conditionalOpcode.keys()))
actionnameRegex = ('|'.join(str(x) for x in actionNameToOpcode.keys()))
registerregex = ('|'.join(str(x) for x in registers.keys()))
labelRegex = r'(?:[0-9]*[A-Za-z_]+[0-9]*)+'
regexjmpreg = r'^(j(?:' + conditionalRegex + '))\s(' + labelRegex + ')$'

labels = {}


class Action:
    actionName = None
    arg = None
    bytes = None

    def __init__(self):
        pass

    @staticmethod
    def parse_action(line: str, argmax=16):
        match = re.match(re.compile(r'^\.ascii\s*"([A-Za-z0-9\\]*)"$'), line)
        if match:
            ret = Action()
            ret.bytes = bytes(match.group(1), 'utf-8')
            return ret

        match = re.match(re.compile(r'^\.bin\s*([01]*)$'), line)
        if match:
            ret = Action()
            ret.actionName = ".bin"
            numbits = len(match.group(1))
            ret.bytes = bytearray(math.floor(numbits / 8))
            for b in range(numbits):
                if match.group(1)[b] == '1':
                    ret.bytes[math.floor((numbits - b - 1) / 8)] |= 1 << ((numbits - b - 1) % 8)
            return ret

        match = re.match(re.compile(r'^\.asciiz\s*"([A-Za-z0-9\\]*)"$'), line)
        if match:
            ret = Action()
            string = match.group(1) + "\0"
            ret.bytes = bytes(string, 'utf-8')
            return ret

        bufferfinder = re.compile(r'^\.buffer\s*([0-9]+)$')
        match = re.match(bufferfinder, line)
        if match:
            ret = Action()
            ret.actionName = ".buffer"
            ret.bytes = bytearray(int(match.group(1)))
            return ret

        # Parse actual action
        actionfinder = re.compile(r'^([A-Za-z0-9]+)(?:\s+?(-?[A-Za-z0-9]*))?$')
        match = re.match(actionfinder, line)
        if not match:
            return None
        ret = Action()
        ret.actionName = match.group(1).lower()
        if not match.group(2):
            return ret
        arg = match.group(2)
        negative = arg.startswith("-")
        if negative:
            arg = arg[1:]
        if arg.startswith("0b"):
            ret.arg = int(arg[2:], 2)
        elif arg.startswith("0x"):
            ret.arg = int(arg[2:], 16)
        else:
            try:
                ret.arg = int(arg, 10)
            except ValueError:
                ret.arg = None
        if negative:
            ret.arg = -ret.arg
            if ret.arg < 0:
                ret.arg += argmax
                if ret.arg < 0:
                    raise Exception("Argument was too negative")
        if ret.arg is None:
            if arg.lower() in registers:
                ret.arg = registers[arg.lower()]
        if (ret.arg is None) and (arg in labels):
            ret.arg = labels[arg]
        if ret.arg is None:
            ret.arg = 0
        if ret.arg >= argmax:
            raise Exception(f"Argument {ret.arg} out of bounds for line {line}")
        return ret

    def to_bytes(self):
        if not self.bytes:
            self.bytes = bytearray(1)
            val = actionNameToOpcode[self.actionName] * 16 + self.arg
            self.bytes[0] = val
        return self.bytes

    def bytelen(self):
        if self.bytes:
            return len(self.bytes)
        return 1


class Label:
    name = ""
    loc = 0

    def __init__(self):
        pass

    @staticmethod
    def parse_label(line: str):
        labelfinder = re.compile(r'^(' + labelRegex + '):$')
        match = re.match(labelfinder, line)
        if not match:
            return None
        ret = Label()
        ret.name = match.group(1)
        return ret


class Assembler:
    program = None
    pc = 0

    def process_action(self, action):
        print(f"{action.actionName}@{hex(labels['pc'])} -> {action.to_bytes().hex()}")
        self.program += action.to_bytes()
        pass

    def process_label(self, label):
        labels[label.name] = labels["pc"]

    def unwrap_line(self, line: str):

        # Multiline things formatted as instructions
        action = Action.parse_action(line, 65536)
        if not action:
            return [line]

        # set mem register from label
        if action.actionName == "setml":
            return [
                "set RAT",
                "clr", f"xori {int(action.arg / 256) % 16}", f"xori {int(action.arg / 4096) % 16}", "set RMH",
                "clr", f"xori {int(action.arg) % 16}", f"xori {int(action.arg / 16) % 16}", "set RML",
                "get RAT"
            ]
        if action.actionName == "setsl":
            # print(f"{line} -> {action.actionName},{action.arg}")
            return [
                "set RAT",
                "clr", f"xori {int(action.arg / 256) % 16}", f"xori {int(action.arg / 4096) % 16}", "set RSH",
                "clr", f"xori {int(action.arg) % 16}", f"xori {int(action.arg / 16) % 16}", "set RSL",
                "get RAT"
            ]

        # inc stack pointer
        if action.actionName == "incsp":
            return ["get RSL", "addi 1", "set RML", "set RSL",
                    "get RSH", "addict 1", "set RMH", "set RSH"]
        # inc memory pointer
        if action.actionName == "incmp":
            return ["get RML", "addi 1", "set RML",
                    "get RMH", "addict 1", "set RMH"]
        # addi memory pointer
        if action.actionName == "addimp":
            return ["get RML", f"addi {action.arg}", "set RML",
                    "get RMH", "addict 1", "set RMH"]
        # add memory pointer
        if action.actionName == "addmp":
            return ["get RML", f"add {action.arg}", "set RML",
                    "get RMH", "addict 1", "set RMH"]

        # Jmp to register
        match = re.match(re.compile(regexjmpreg), line)
        if match:
            return [f"setml {match.group(2)}", match.group(1)]

        # conditional instructions
        match = re.match(re.compile(r'^(\w+)(' + conditionalRegex + ')(.*)$'), line)
        if match:
            instruction = match.group(1)
            condition = match.group(2)
            arg = match.group(3)
            if instruction == 's' or instruction == 'j':
                return [f"{instruction} {conditionalOpcode[condition]}"]
            else:
                # print(f"conditional split: {line} -> s{condition}, {instruction}{arg}")
                # Do-if = ~skip-if
                return [f"s {conditionalOpcode[condition] ^ 1}", f"{instruction}{arg}"]
        # alias instructions
        if action.actionName == "addi8":
            # put rac in RAT, setup acc, add
            return ["set RAT", "clr", f"ori {action.arg % 16}", f"ori {int(action.arg / 16)}", "add RAT"]
        if action.actionName == "clr":
            return ["xor rac"]
        if action.actionName == "nop":
            # Done instead of addi 0 so that it doesn't interfere with carry
            return ["and rac"]
        if action.actionName == "push":
            # Increments then writes
            return ["set RAT",
                    "incsp",
                    "wb RAT", "get RAT"]
        if action.actionName == "pushpc":
            return ["push16 pc"]
        if action.actionName == "push16":
            return [
                # Push Lower 8 bits
                "clr", f"addi8 {int(action.arg/256)}", "push",
                # Push Upper 8 bits
                "clr", f"addi8 {action.arg%256}", "push",
            ]
        if action.actionName == "pop":
            # Reads then decrements
            return ["get RSL", "set RML", "subi 1", "set RSL",
                    "get RSH", "set RMH", "subicf 1", "set RSH",
                    "rb ACC"]

        if action.actionName == "pushml":
            # Increments then writes
            return ["set RAT",
                    # upper
                    "incsp",
                    "clr", f"xori {int(action.arg / 256) % 16}", f"xori {int(action.arg / 4096) % 16}", "wb ACC",

                    # lower
                    "incsp",
                    "clr", f"xori {int(action.arg) % 16}", f"xori {int(action.arg / 16) % 16}", "wb ACC",

                    "get RAT"]
        if action.actionName == "popml":  # Destroys ACC
            # Reads then decrements
            return [
                # Read upper to RAT, decrement SP
                "get RSL", "set RML", "subi 1", "set RSL",
                "get RSH", "set RMH", "subicf 1", "set RSH",
                "rb RAT",
                # Read lower to RML, decrement SP
                "get RSL", "set RML", "subi 1", "set RSL",
                "get RSH", "set RMH", "subicf 1", "set RSH",
                "rb RML",
                # set RAT to RML
                "get RAT", "set RMH"
            ]

        return [line]

    def lines_strip_comments(self, lines):
        labels["pc"] = 0
        while labels["pc"] < len(lines):
            # Strip Comments
            comment_index = max(lines[labels["pc"]].find("//"), lines[labels["pc"]].find("#"),
                                lines[labels["pc"]].find(";"))
            if comment_index != -1:
                lines[labels["pc"]] = lines[labels["pc"]][:comment_index]
            # Strip Whitespace
            lines[labels["pc"]] = lines[labels["pc"]].strip()
            # Remove Empty Lines
            if lines[labels["pc"]] == '':
                del lines[labels["pc"]]
                continue
            labels["pc"] += 1
        return lines

    def lines_unwrap(self, lines):
        while True:
            newlines = []
            labels["pc"] = 0
            oldpc = 0
            while oldpc < len(lines):
                toAdd = self.unwrap_line(lines[oldpc])
                for line in toAdd:
                    newlines.append(line)
                    labels["pc"] = labels["pc"] + 1
                oldpc += 1
            if newlines == lines:
                break
            lines = newlines
            print(lines)
        return newlines

    def lines_process_labels(self, lines):
        labels["pc"] = 0
        for line in lines:
            label = Label.parse_label(line)
            if label:
                self.process_label(label)
            action = Action.parse_action(line)
            if action:
                labels["pc"] = labels["pc"] + action.bytelen()

    def __init__(self, filename, memory):
        self.program = bytearray(memory)
        with open("Assembler/" + filename, 'r') as file:
            filedata = file.read()
            lines = filedata.split('\n')
            print("PHASE 0 - strip comments")
            # Strip comments
            lines = self.lines_strip_comments(lines)
            print(lines)
            print("PHASE 1 - Pseudounwrap for labels")
            lines_for_labelling = self.lines_unwrap(lines)
            print(lines_for_labelling)
            print("PHASE 2 - Process All Labels")
            self.lines_process_labels(lines_for_labelling)
            for label in labels.keys():
                print(f"{label} -> {labels[label]},{hex(labels[label])}")
            print("PHASE 3 - Actual Unwrap")
            lines = self.lines_unwrap(lines)
            print("PHASE 4 - Process All Actions")
            labels["pc"] = 0
            for line in lines:
                action = Action.parse_action(line)
                if action:
                    self.process_action(action)
                    labels["pc"] = labels["pc"] + len(action.to_bytes())
                elif not Label.parse_label(line):
                    print(f"UNKNOWN LINE {line}", file=sys.stderr)
            print("PHASE 5 - Make Hex")
            prog_hex = self.program.hex()

            numbytes = len(self.program)
            print(prog_hex)
            print(str(numbytes) + "/65536 = " + str(round(numbytes / 655.360, 3)) + "%")

            with open(f"{Path.home()}/{filename}.hex", 'w') as out:
                out.write("v3.0 hex bytes plain big-endian\r")
                out.write(prog_hex)
                out.flush()
                out.close()


if __name__ == '__main__':
    Assembler("code.asm", 0)
    # Assembler("beef.asm", 0)
