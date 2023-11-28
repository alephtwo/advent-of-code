use criterion::{criterion_group, criterion_main, Criterion};

use aoc2015::{
    day01::{part_one, part_two},
    util,
};

fn criterion_benchmark(c: &mut Criterion) {
    let input = util::read_input("01");
    c.bench_function("part one", |b| {
        b.iter(|| {
            part_one(&input);
        })
    });
    c.bench_function("part two", |b| {
        b.iter(|| {
            part_two(&input);
        })
    });
}

criterion_group!(benches, criterion_benchmark);
criterion_main!(benches);
