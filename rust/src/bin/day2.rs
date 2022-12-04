use std::fs;

fn main() {
    println!("{}", part1());
    println!("{}", part2());
}

fn part1() -> i32 {
    input().split("\n").fold(0, |score, round| {
        let round = round
            .split(" ")
            .map(|c| c.bytes().nth(0).unwrap())
            .collect::<Vec<_>>();
        let you = (round[0] - 65) as i32;
        let me = (round[1] - 88) as i32;

        score
            + match (you, me) {
                (a, b) if a == b => 3 + me + 1,
                (0, 1) | (1, 2) | (2, 0) => 6 + me + 1,
                _ => me + 1,
            }
    })
}

fn part2() -> i32 {
    let win = |rsp: i32| (rsp + 1) % 3;
    let lose = |rsp: i32| ((rsp - 1) % 3).abs();
    input().split("\n").fold(0, |score, round| {
        let round = round
            .split(" ")
            .map(|c| c.bytes().nth(0).unwrap())
            .collect::<Vec<_>>();
        let you = round[0] as i32 - 65;
        let mov = round[1] as i32 - 88;
        score
            + match mov {
                0 => lose(you) + 1,
                1 => 3 + you + 1,
                2 => win(you) + 6 + 1,
                _ => unreachable!(),
            }
    })
}

fn input() -> String {
    String::from_utf8(fs::read("../inputs/day2.txt").unwrap()).unwrap()
}
