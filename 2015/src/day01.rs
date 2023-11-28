pub fn part_one(input: impl Into<String>) -> i16 {
    input
        .into()
        .chars()
        .map(|x| if x == '(' { 1 } else { -1 })
        .sum()
}

pub fn part_two(input: impl Into<String>) -> i16 {
    let mut floor = 0;
    for (i, c) in input.into().chars().enumerate() {
        floor += match c {
            '(' => 1,
            ')' => -1,
            _ => panic!("uh"),
        };
        if floor < 0 {
            return (i + 1) as i16;
        }
    }

    panic!("uh oh");
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn sample_part_one() {
        assert_eq!(part_one("(())"), 0);
        assert_eq!(part_one("()()"), 0);
        assert_eq!(part_one("((("), 3);
        assert_eq!(part_one("(()(()("), 3);
        assert_eq!(part_one("))((((("), 3);
        assert_eq!(part_one("())"), -1);
        assert_eq!(part_one("))("), -1);
        assert_eq!(part_one(")))"), -3);
        assert_eq!(part_one(")())())"), -3);
    }

    #[test]
    fn final_part_one() {
        assert_eq!(part_one(crate::util::read_input("01")), 74);
    }

    #[test]
    fn sample_part_two() {
        assert_eq!(part_two(")"), 1);
        assert_eq!(part_two("()())"), 5);
    }

    #[test]
    fn final_part_two() {
        assert_eq!(part_two(crate::util::read_input("01")), 1795);
    }
}
