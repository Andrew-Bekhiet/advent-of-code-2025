defmodule Day5Test do
  use ExUnit.Case
  doctest Day5

  test "Part 1" do
    assert Day5.part1(true) == 3
    :timer.tc(Day5, :part1, [false]) |> inspect() |> IO.puts()
  end

  test "Part 2" do
    assert Day5.part2(true) == 14
    :timer.tc(Day5, :part2, [false]) |> inspect() |> IO.puts()
  end
end
