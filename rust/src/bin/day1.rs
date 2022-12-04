use std::fs;

fn main() {
    println!("{}", part1());
    println!("{}", part2());
}

fn part1() -> i32 {
    input()
        .split("\n\n")
        .map(|foods| {
            foods
                .split("\n")
                .map(|val| val.parse::<i32>().unwrap())
                .sum()
        })
        .max()
        .unwrap()
}

fn part2() -> i32 {
    let mut calories: Vec<i32> = input()
        .split("\n\n")
        .map(|foods| {
            foods
                .split("\n")
                .map(|val| val.parse::<i32>().unwrap())
                .sum()
        })
        .collect();
    calories.sort();
    calories.reverse();
    calories.into_iter().take(3).sum()
}

fn input() -> String {
    String::from_utf8(fs::read("../inputs/day1.txt").unwrap()).unwrap()
}
