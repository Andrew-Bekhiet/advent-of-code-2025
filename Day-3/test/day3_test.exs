defmodule Day3Test do
  use ExUnit.Case
  doctest Day3

  test "Part 1" do
    assert Day3.part1(true) == 357
    :timer.tc(Day3, :part1, [false]) |> inspect() |> IO.puts()
  end

  test "Part 2" do
    assert Day3.part2(true) == 3_121_910_778_619
    :timer.tc(Day3, :part2, [false]) |> inspect() |> IO.puts()
  end
end
