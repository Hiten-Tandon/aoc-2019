use get_day.nu

export def part1 [] {
  get_day initialize 4
  let range = open ~/.cache/aoc/2019/day4/input.txt | str trim | split row "-" | each { into int }
  let res = (
    $range.0..$range.1
      | par-each { into string | split chars | window 2 }
      | par-each { ($in | all {$in.0 <= $in.1}) and ($in | any {$in.0 == $in.1})  }
      | filter { $in }
      | length
  );
  wl-copy $res
  $res
}

export def part2 [] {
  get_day initialize 4
  let range = open ~/.cache/aoc/2019/day4/input.txt | str trim | split row "-" | each { into int }
  let res = (
    $range.0..$range.1
      | par-each { into string | split chars }
      | par-each {(
          ($in | window 2 | all {$in.0 <= $in.1}) 
          and ($in | uniq -c | get count | any {$in == 2})
      )}
      | filter { $in }
      | length
  );
  wl-copy $res
  $res
}
