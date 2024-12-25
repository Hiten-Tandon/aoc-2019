use get_day.nu
export def part1 [] {
  get_day initialize 1
  let res = (
    open ~/.cache/aoc/2019/day1/input.txt
      | lines
      | each { into int }
      | each { $in // 3 - 2 }
      | math sum
  );
  wl-copy $res
  $res
}

export def part2 [] {
  get_day initialize 1
  def rec [x: int] int {
    if $x <= 2 {
      0
    } else {
      (($x // 3) - 2) + (rec (($x // 3) - 2))
    }
  }
  let res = (
    open ~/.cache/aoc/2019/day1/input.txt
      | lines
      | each { into int }
      | each { rec $in }
      | math sum
  );
  wl-copy $res
  $res
}
