package net.datadeer;

public class Pair <T> {
    public final String a;
    public final String b;

    Pair(String a, String b) {
        this.a = a;
        this.b = b;
    }

    public static Pair<String> split(String str, String delim) {
        int indexFirstSpace = str.indexOf(delim);
        return new Pair<>(
                indexFirstSpace==-1?str:str.substring(0, indexFirstSpace),
                indexFirstSpace==-1?""  :str.substring(indexFirstSpace+1)
        );
    }
}
