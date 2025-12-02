defmodule Day1Test do
  use ExUnit.Case
  doctest Day1

  # test "Part 1" do
  #   assert Day1.part1(true) == 3
  #   :timer.tc(Day1, :part1, [false]) |> inspect() |> IO.puts()
  # end

  test "Part 2" do
    assert Day1.part2(true) == 6
    day2_result = :timer.tc(Day1, :part2, [false])

    assert day2_result |> elem(1) != 7373
    assert day2_result |> elem(1) != 7106
    assert day2_result |> elem(1) != 7096
    assert day2_result |> elem(1) != 6689

    day2_result |> inspect() |> IO.puts()
  end
end
