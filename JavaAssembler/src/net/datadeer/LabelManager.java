package net.datadeer;

import java.util.HashMap;

class LabelManager {

    private static HashMap<String,Integer> labels = new HashMap<>();

    static void addLabel(String name, int location) {
        labels.putIfAbsent(name, location);
    }

    static boolean hasLabel(String name) {
        return labels.containsKey(name);
    }

    static int getLabel(String name) {
        return labels.get(name);
    }

}
