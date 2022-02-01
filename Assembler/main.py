import re

from pathlib import Path


class Action:
    actionName = None
    arg = None

    actionNameToOpcode = {
        "addi":  0x0,
        "add":   0x1,
        "andi":  0x2,
        "and":   0x3,
        "lsli":  0x4,
        "lsl":   0x5,
        "nandi": 0x6,
        "nand":  0x7,
        "mov":   0x8,
        "0x9":   0x9,
        "0xA":   0xA,
        "0xB":   0xB,
        "jmp":   0xC,
        "jnz":   0xD,
        "wb":    0xE,
        "rb":    0xF,
    }

    def __init__(self):
        pass

    @staticmethod
    def parse_action(line: str, argmax=16):
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

    def toByte(self):
        return self.actionNameToOpcode[self.actionName]*16 + self.arg


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
        print(f"{action.actionName}@{self.pc} -> {hex(action.toByte())}")
        self.program[self.pc] = action.toByte()
        self.pc = self.pc + 1
        pass

    def process_label(self, label):
        self.labels[label.name] = self.pc

    def process_line(self, line: str):
        action = Action.parse_action(line)
        if action:
            self.process_action(action)
        label = Label.parse_label(line)
        if label:
            self.process_label(label)

    def unwrap_line(self, line: str, pc: int):
        jmptolabel = re.compile(r'^(jnz|jmp|jer|jlt)\s([A-Za-z0-9_]+)$')
        match = re.match(jmptolabel, line)
        if match:

            label = self.labels.get(match.group(2)) or 0
            return ["andi 0", f"addi {(label/4096)%16}", f"lsli 4", f"addi {(label/256)%16}", "mov R15",
                    "andi 0", f"addi {(label/16  )%16}", f"lsli 4", f"addi {(label    )%16}", "mov R14",
                    f"{match.group(1).lower()}"]

        action = Action.parse_action(line, 256)
        if not action:
            return [line]
        if action.actionName == "clr":
            return ["andi 0"]
        if action.actionName == "nop":
            return ["addi 0"]
        if action.actionName == "lsri":
            return [f"lsli {-action.arg}"]
        if action.actionName == "set":
            return ["andi 0", f"add {action.arg}"]
        if action.actionName == "seti8":
            return ["andi 0", f"addi {action.arg/16}", "lsli 4", f"addi {action.arg%16}"]
        if action.actionName == "subi":
            return [f"addi {-action.arg}"]

        return [line]

    def __init__(self, filename, memory):
        self.program = bytearray(memory)
        with open("Assembler/"+filename, 'r') as file:
            filedata = file.read()
            lines = filedata.split('\n')

            print("PHASE 0")
            # Strip comments
            self.pc = 0
            while self.pc < len(lines):
                # Strip Whitespace
                lines[self.pc] = lines[self.pc].strip()
                # Strip Comments
                comment_index = max(lines[self.pc].find("//"), lines[self.pc].find(";"))
                if comment_index != -1:
                    lines[self.pc] = lines[self.pc][:comment_index]
                # Remove Empty Lines
                if lines[self.pc] == '':
                    del lines[self.pc]
                    continue
                self.pc = self.pc+1
            print("PHASE0 DONE")
            # print(lines)

            print("PHASE 1")
            self.pc = 0
            newlines = []
            while self.pc < len(lines):
                toAdd = self.unwrap_line(lines[self.pc], self.pc)
                for line in toAdd:
                    newlines.append(line)
                self.pc = self.pc + 1
            lines = newlines
            print("PHASE1 DONE")
            print(lines)

            print("PHASE 2")
            self.pc = 0
            for line in lines:
                self.process_line(line)

            progHex = self.program.hex()

            for label in self.labels.keys():
                print(f"{label} -> {self.labels[label]}")

            print(progHex)
            with open(f"{Path.home()}/{filename}.hex", 'w') as out:
                out.write("v3.0 hex bytes plain big-endian\r")
                out.write(progHex)
                out.flush()
                out.close()


if __name__ == '__main__':
    s = Assembler("code.asm", 64)
