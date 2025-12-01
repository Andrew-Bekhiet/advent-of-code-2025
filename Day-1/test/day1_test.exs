defmodule Day1Test do
  use ExUnit.Case
  doctest Day1

  test "Part 1" do
    assert Day1.part1(true) == 3
    :timer.tc(Day1, :part1, [false]) |> inspect() |> IO.puts()
  end

  test "Part 2" do
    assert Day1.part2(true) == 6
    :timer.tc(Day1, :part2, [false]) |> inspect() |> IO.puts()
  end
end
