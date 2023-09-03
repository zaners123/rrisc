package net.datadeer;

abstract class Argument {
    String str;

    Argument(String str) {
        this.str = str;
    }

    public abstract Nibble toBin();
}
