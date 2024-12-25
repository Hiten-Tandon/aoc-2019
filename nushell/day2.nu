use get_day.nu

export def part1 [] {
  get_day initialize 2
  mut prog = open ~/.cache/aoc/2019/day2/input.txt | split row , | each { into int }
  $prog.1 = 12
  $prog.2 = 2

  mut i = 0;
  while (($prog | get $i) != 99) {
    let opcode = $prog | get $i

    $prog = (match $opcode {
      1 => ($prog | update ($prog | get ($i + 3)) (($prog | get ($prog | get ($i + 1))) + ($prog | get ($prog | get ($i + 2)))))
      2 => ($prog | update ($prog | get ($i + 3)) (($prog | get ($prog | get ($i + 1))) * ($prog | get ($prog | get ($i + 2)))))
      _ => $prog
    })
    $i += 4
  }

  wl-copy ($prog | get 0)
  $prog | get 0
}

export def part2 [] {
  get_day initialize 2
  let prog = open ~/.cache/aoc/2019/day2/input.txt | split row , | each { into int }
  let res = (
    0..99 | par-each {|noun| 
      0..99 | par-each {|verb|
        mut prog = $prog
        $prog.1 = $noun
        $prog.2 = $verb

        mut i = 0;
        while (($prog | get $i) != 99) {
          let opcode = $prog | get $i

          $prog = (match $opcode {
            1 => ($prog | update ($prog | get ($i + 3)) (($prog | get ($prog | get ($i + 1))) + ($prog | get ($prog | get ($i + 2)))))
            2 => ($prog | update ($prog | get ($i + 3)) (($prog | get ($prog | get ($i + 1))) * ($prog | get ($prog | get ($i + 2)))))
            _ => $prog
          })
          $i += 4
        }
        {key: ($noun * 100 + $verb), val: ($prog | get 0)}
      }
    }
    | flatten
    | where val == 19690720
  ).key.0
  wl-copy $res
  $res
}
