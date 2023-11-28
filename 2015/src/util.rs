use std::fs;

pub fn read_input(filename: &str) -> String {
    fs::read_to_string(format!("input/{}.txt", filename)).expect("unable to read file")
}
