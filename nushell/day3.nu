use get_day.nu
use std/iter
export def part1 [] {
  get_day initialize 3
  let data = (
    open ~/.cache/aoc/2019/day3/input.txt
      | lines
      | par-each { 
          split row ,
          | iter scan [{x: 0, y: 0}] {|acc, x| 
            let data = ($x | parse --regex '(?<direction>.)(?<count>\d+)' | update count { into int }).0
            (1..$data.count) | iter scan ($acc | last) {|acc, x| 
              match $data.direction {
                L => ($acc | update x {$in - 1})
                R => ($acc | update x {$in + 1})
                D => ($acc | update y {$in - 1})
                U => ($acc | update y {$in + 1})
                _ => $acc
              }
            }
          }
          | flatten
          | uniq-by x y
          | where x != 0 or y != 0
      }
      | enumerate
      | update index {$"w($in + 1)"}
      | transpose -ri
    )
  let w1 = $data.w1.0
  let w2 = $data.w2.0

  def manhattan_dist [point: record<x: int, y: int>] int {
    return (($point.x | math abs) + ($point.y | math abs))
  }

  let res = $w1 | append $w2 | uniq-by x y -d | par-each {manhattan_dist $in} | math min
  wl-copy $res
  $res
}

export def part2 [] {
  get_day initialize 3
  let data = (
    open ~/.cache/aoc/2019/day3/input.txt
      | lines
      | par-each { 
          split row ,
          | iter scan [{x: 0, y: 0, steps: 0}] {|acc, x| 
            let data = ($x | parse --regex '(?<direction>.)(?<count>\d+)' | update count { into int }).0
            (1..$data.count) | iter scan ($acc | last) {|acc, x| 
              match $data.direction {
                L => ($acc | update x {$in - 1} | update steps {$in + 1})
                R => ($acc | update x {$in + 1} | update steps {$in + 1})
                D => ($acc | update y {$in - 1} | update steps {$in + 1})
                U => ($acc | update y {$in + 1} | update steps {$in + 1})
                _ => $acc
              }
            }
          }
          | flatten
          | uniq-by x y
          | insert coordinate {$"($in.x),($in.y)"}
          | where x != 0 or y != 0
      }
      | enumerate
      | update index {$"w($in + 1)"}
      | transpose -ri
    )
  let w1 = $data.w1.0
  let w2 = $data.w2.0

  def manhattan_dist [point: record<x: int, y: int>] int {
    return (($point.x | math abs) + ($point.y | math abs))
  }

  let res = (
    $w1 | append $w2 
        | group-by coordinate --to-table 
        | filter { ($in.items | length) == 2 } 
        | each { $in.items.steps | math sum }
        | math min
  )
  wl-copy $res
  $res
}
