import re

from pathlib import Path

jumpToOpcode = {
    "jal": 0x0,
    "jno": 0x1,
    "jnz": 0x2,
    "jez": 0x3,
    "jlz": 0x4,
    "jgz": 0x5,
    "jlt": 0x6,
    "jge": 0x7,
    "jeq": 0x8,
    "jne": 0x9,
    "jgt": 0xA,
    "jle": 0xB,
    "jod": 0xC,
    "jev": 0xD,
    "0xE": 0xE,
    "0xF": 0xF,
}

actionNameToOpcode = {
    "addi":  0x0,
    "add":   0x1,
    "subi":  0x2,
    "sub":   0x3,
    "andi":  0x4,
    "and":   0x5,
    "get":   0x6,
    "set":   0x7,
    "ori":   0x8,
    "or":    0x9,
    "xori":  0xA,
    "xor":   0xB,
    "roll":  0xC,
    "jmp":   0xD,
    "rb":    0xE,
    "wb":    0xF,
}


class Action:

    actionName = None
    arg = None
    bytes = None

    def __init__(self):
        pass

    @staticmethod
    def parse_action(line: str, argmax=16):

        asciifinder = re.compile(r'^\.ascii\s*"([A-Za-z0-9\\]*)"$')
        match = re.match(asciifinder, line)
        if match:
            ret = Action()
            ret.bytes = bytes(match.group(1), 'utf-8')
            return ret

        asciizfinder = re.compile(r'^\.asciiz\s*"([A-Za-z0-9\\]*)"$')
        match = re.match(asciizfinder, line)
        if match:
            ret = Action()
            string = match.group(1)+"\0"
            ret.bytes = bytes(string, 'utf-8')
            return ret

        bufferfinder = re.compile(r'^\.buffer\s*([0-9]+)$')
        match = re.match(bufferfinder, line)
        if match:
            ret = Action()
            ret.bytes = bytearray(int(match.group(1)))
            return ret

        actionfinder = re.compile(r'^([A-Za-z0-9]+)\s*#?R?((?:-|0x|0b)?[0-9A-Fa-f]+)?$')
        match = re.match(actionfinder, line)
        if not match:
            return None
        ret = Action()
        ret.actionName = match.group(1).lower()
        if match.group(2):
            if match.group(2).startswith("0b"):
                ret.arg = int(match.group(2)[2:], 2)
            elif match.group(2).startswith("0x"):
                ret.arg = int(match.group(2)[2:], 16)
            else:
                ret.arg = int(match.group(2), 10)
                if ret.arg < 0:
                    ret.arg += argmax
                    if ret.arg < 0:
                        raise Exception("Argument was too negative")
            if ret.arg >= argmax:
                raise Exception(f"Argument {ret.arg} out of bounds for line {line}")
        else:
            ret.arg = 0
        return ret

    def to_bytes(self):
        if not self.bytes:
            self.bytes = bytearray(1)
            val = actionNameToOpcode[self.actionName] * 16 + self.arg
            self.bytes[0] = val
        return self.bytes


class Label:
    name = ""
    loc = 0

    def __init__(self):
        pass

    @staticmethod
    def parse_label(line: str):
        labelfinder = re.compile(r'^([A-Za-z_0-9]+):$')
        match = re.match(labelfinder, line)
        if not match:
            return None
        ret = Label()
        ret.name = match.group(1)
        return ret


class Assembler:
    program = None
    pc = 0
    labels = {}

    def process_action(self, action):
        print(f"{action.actionName}@{self.pc} -> {action.to_bytes().hex()}")
        self.program += action.to_bytes()
        pass

    def process_label(self, label):
        self.labels[label.name] = self.pc

    def unwrap_line(self, line: str):
        jmptolabel = re.compile(r'^(j[a-z]{2})\s([A-Za-z0-9_]+)$')
        match = re.match(jmptolabel, line)
        if match:
            label = self.labels.get(match.group(2)) or 0
            return ["sub R0", f"addi {int(label/4096)%16}", f"andi 0xF", f"addi {int(label/256)%16}", "set R15",
                    "sub R0", f"addi {int(label/16  )%16}", f"andi 0xF", f"addi {int(label    )%16}", "set R14",
                    f"jmp {jumpToOpcode[match.group(1)]}"]

        action = Action.parse_action(line, 256)
        if not action:
            return [line]
        if action.actionName == "clr":
            return ["sub R0"]
        if action.actionName == "nop":
            return ["addi 0"]
        # if action.actionName == "lsri":
        #     return [f"lsli {-action.arg}"]
        # if action.actionName == "geti8":
        #     return ["andi 0", f"addi {action.arg/16}", "lsli 4", f"addi {action.arg%16}"]
        return [line]

    def lines_strip_comments(self, lines):
        self.pc = 0
        while self.pc < len(lines):
            # Strip Comments
            comment_index = max(lines[self.pc].find("//"), lines[self.pc].find(";"))
            if comment_index != -1:
                lines[self.pc] = lines[self.pc][:comment_index]
            # Strip Whitespace
            lines[self.pc] = lines[self.pc].strip()
            # Remove Empty Lines
            if lines[self.pc] == '':
                del lines[self.pc]
                continue
            self.pc += 1
        return lines

    def lines_unwrap(self, lines):
        self.pc = 0
        oldpc = 0
        newlines = []
        while oldpc < len(lines):
            toAdd = self.unwrap_line(lines[oldpc])
            for line in toAdd:
                newlines.append(line)
                self.pc = self.pc + 1
            oldpc += 1
        return newlines

    def lines_process_labels(self, lines):
        self.pc = 0
        for line in lines:
            label = Label.parse_label(line)
            if label:
                self.process_label(label)
            action = Action.parse_action(line)
            if action:
                self.pc = self.pc + len(action.to_bytes())

    def __init__(self, filename, memory):
        self.program = bytearray(memory)
        with open("Assembler/"+filename, 'r') as file:
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
            for label in self.labels.keys():
                print(f"{label} -> {self.labels[label]}")
            print("PHASE 3 - Actual Unwrap")
            lines = self.lines_unwrap(lines)

            print("PHASE 4 - Process All Actions")
            self.pc = 0
            for line in lines:
                action = Action.parse_action(line)
                if action:
                    self.process_action(action)
                    self.pc = self.pc + len(action.to_bytes())

            print("PHASE 5 - Make Hex")
            prog_hex = self.program.hex()
            print(prog_hex)
            with open(f"{Path.home()}/{filename}.hex", 'w') as out:
                out.write("v3.0 hex bytes plain big-endian\r")
                out.write(prog_hex)
                out.flush()
                out.close()


if __name__ == '__main__':
    s = Assembler("code.asm", 0)
