defmodule Day4Test do
  use ExUnit.Case
  doctest Day4

  test "Part 1" do
    assert Day4.part1(true) == 13
    :timer.tc(Day4, :part1, [false]) |> inspect() |> IO.puts()
  end

  test "Part 2" do
    assert Day4.part2(true) == 43
    :timer.tc(Day4, :part2, [false]) |> inspect() |> IO.puts()
  end
end
