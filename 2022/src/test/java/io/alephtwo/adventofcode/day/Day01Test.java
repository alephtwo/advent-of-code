package io.alephtwo.adventofcode.day;

import io.alephtwo.adventofcode.util.InputLoader;
import java.nio.file.Paths;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertEquals;

class Day01Test {
    private static final Day DAY = new Day01();

    private static final String SAMPLE_INPUT =
            """
        1000
        2000
        3000

        4000

        5000
        6000

        7000
        8000
        9000

        10000
        """;

    private static final String PUZZLE_INPUT = InputLoader.loadInput(Paths.get("./input/01.txt"));

    @Test
    void partOneExamples() {
        assertEquals(24_000, DAY.partOne(SAMPLE_INPUT));
    }

    @Test
    void partOneSolution() {
        assertEquals(68_802, DAY.partOne(PUZZLE_INPUT));
    }

    @Test
    void partTwoExamples() {
        assertEquals(45_000, DAY.partTwo(SAMPLE_INPUT));
    }

    @Test
    void partTwoSolution() {
        assertEquals(205_370, DAY.partTwo(PUZZLE_INPUT));
    }
}
