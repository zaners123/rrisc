package net.datadeer;

class Nibble {
    public final byte nibble;

    Nibble(int nibble) { this.nibble = (byte)nibble; }

    public char toChar() {
        return (char) ((nibble>=10?'A'-10:'0') + nibble);
    }
}
