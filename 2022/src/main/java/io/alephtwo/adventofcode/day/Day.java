package io.alephtwo.adventofcode.day;

import io.alephtwo.adventofcode.core.StopThePressesException;
import java.io.IOException;
import java.net.URISyntaxException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.stream.Stream;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public abstract class Day {
    private final String filename;

    protected Day(final String filename) {
        this.filename = filename;
    }

    public final int partOne() {
        return partOne(getPuzzleInput());
    }

    public abstract int partOne(final String input);

    public final int partTwo() {
        return partTwo(getPuzzleInput());
    }

    public abstract int partTwo(final String input);

    protected Stream<String> readInput() {
        try {
            return Files.lines(getInputPath());
        } catch (IOException e) {
            throw new StopThePressesException(e);
        }
    }

    private String getPuzzleInput() {
        try {
            return Files.readString(getInputPath());
        } catch (IOException e) {
            throw new StopThePressesException(e);
        }
    }

    private Path getInputPath() {
        final var path = getClass().getResource(filename);
        if (path == null) {
            throw new StopThePressesException("File cannot be null");
        }
        try {
            return Path.of(path.toURI());
        } catch (URISyntaxException e) {
            throw new StopThePressesException(e);
        }
    }
}
