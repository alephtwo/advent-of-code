package io.alephtwo.adventofcode.day;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class Day01 extends Day {
    private static final Logger LOG = LoggerFactory.getLogger(Day01.class);

    public Day01() {
        super("01.txt");
    }

    public static void main(final String[] args) {
        final var day = new Day01();
        LOG.info("Part One: {}", day.partOne());
        LOG.info("Part Two: {}", day.partTwo());
    }

    @Override
    public int partOne(final String input) {
        return 0;
    }

    @Override
    public int partTwo(final String input) {
        return 0;
    }
}
