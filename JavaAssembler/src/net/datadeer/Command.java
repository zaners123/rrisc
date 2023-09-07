package net.datadeer;

abstract class Command {

    String lineRaw;

    Command() {}

    public String getLineRaw() {
        return lineRaw;
    }

    public abstract Nibble[] toNibbles(LabelManager lm);

    protected int getNumBytes(LabelManager lm) {
        return toNibbles(lm).length/2;
    }
}
