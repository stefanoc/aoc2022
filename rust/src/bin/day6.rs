use std::collections::HashSet;
use std::fs;

fn input() -> String {
    String::from_utf8(fs::read("../inputs/day6.txt").unwrap()).unwrap()
}

fn main() {
    println!("{}", part1());
    println!("{}", part2());
}

fn unique<'a>(items: &'a [u8]) -> bool {
    let iter = items.into_iter();
    let set: HashSet<&u8> = iter.collect();
    set.len() == items.len()
}

fn part1() -> usize {
    let input = input();
    let pkt = input
        .as_bytes()
        .windows(4)
        .enumerate()
        .find(|(_, packet)| unique(packet));

    pkt.unwrap().0 + 4
}

fn part2() -> usize {
    let input = input();
    let pkt = input
        .as_bytes()
        .windows(14)
        .enumerate()
        .find(|(_, packet)| unique(packet));

    pkt.unwrap().0 + 14
}
