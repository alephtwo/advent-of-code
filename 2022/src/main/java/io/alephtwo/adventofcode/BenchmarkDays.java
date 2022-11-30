package io.alephtwo.adventofcode;

import io.alephtwo.adventofcode.day.Day;
import io.alephtwo.adventofcode.day.Day01;
import java.io.IOException;
import java.util.concurrent.TimeUnit;
import org.openjdk.jmh.Main;
import org.openjdk.jmh.annotations.Benchmark;
import org.openjdk.jmh.annotations.BenchmarkMode;
import org.openjdk.jmh.annotations.Fork;
import org.openjdk.jmh.annotations.Measurement;
import org.openjdk.jmh.annotations.Mode;
import org.openjdk.jmh.annotations.OutputTimeUnit;
import org.openjdk.jmh.annotations.Scope;
import org.openjdk.jmh.annotations.State;
import org.openjdk.jmh.annotations.Warmup;
import org.openjdk.jmh.infra.Blackhole;

@BenchmarkMode(Mode.AverageTime)
@OutputTimeUnit(TimeUnit.MICROSECONDS)
@Warmup(time = 2, iterations = 1)
@Measurement(time = 5, iterations = 1)
@Fork(1)
public class BenchmarkDays {
    public static void main(final String[] args) throws IOException {
        Main.main(args);
    }

    @Benchmark
    public void day01PartOne(final Blackhole blackhole, final BenchmarkState state) {
        blackhole.consume(state.day01.partOne());
    }

    @Benchmark
    public void day01PartTwo(final Blackhole blackhole, final BenchmarkState state) {
        blackhole.consume(state.day01.partTwo());
    }

    @State(Scope.Benchmark)
    public static class BenchmarkState {
        public final Day day01 = new Day01();
    }
}
