package io.alephtwo.adventofcode.day;

import io.alephtwo.adventofcode.core.StopThePressesException;
import java.util.Arrays;
import java.util.Collections;
import java.util.stream.IntStream;

public class Day01 implements Day {
    @Override
    public int partOne(final String input) {
        return parseInput(input).max().orElseThrow(() -> new StopThePressesException("no max"));
    }

    @Override
    public int partTwo(final String input) {
        return parseInput(input)
                .boxed()
                .sorted(Collections.reverseOrder())
                .limit(3)
                .mapToInt(Integer::intValue)
                .sum();
    }

    private IntStream parseInput(final String input) {
        return Arrays.stream(input.split("\n\n"))
                .map(elf -> elf.lines().map(Integer::parseInt).toList())
                .flatMapToInt(elf ->
                        IntStream.of(elf.stream().mapToInt(Integer::intValue).sum()));
    }
}
