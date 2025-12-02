defmodule Day2Test do
  use ExUnit.Case
  doctest Day2

  test "Part 1" do
    assert Day2.part1(true) == 1_227_775_554
    :timer.tc(Day2, :part1, [false]) |> inspect() |> IO.puts()
  end

  test "Part 2" do
    assert Day2.part2(true) == 4_174_379_265
    :timer.tc(Day2, :part2, [false]) |> inspect() |> IO.puts()
  end
end
