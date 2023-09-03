package net.datadeer;

abstract class Command {

    String lineRaw;

    Command() {}

    public String getLineRaw() {
        return lineRaw;
    }

    public abstract Nibble[] toNibbles();

    protected int getNumBytes() {
        return toNibbles().length/2;
    }
}
