package io.alephtwo.adventofcode.util;

import io.alephtwo.adventofcode.core.StopThePressesException;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;

public class InputLoader {
    private InputLoader() {
        // no direct instantiation
    }

    public static String loadInput(final Path path) {
        try {
            return Files.readString(path);
        } catch (IOException e) {
            throw new StopThePressesException(e);
        }
    }
}
