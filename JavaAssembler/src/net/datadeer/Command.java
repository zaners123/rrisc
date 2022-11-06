package net.datadeer;

abstract class Command {

    CommandLine cl;

    Command() {}

    public String getLineRaw() {
        return cl.lineRaw;
    }

    public abstract Nibble[] toNibbles();
}
