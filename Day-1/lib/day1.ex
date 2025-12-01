defmodule Day1 do
  def part1(use_example) do
    parse_input(use_example)
    |> Enum.map(fn l ->
      {dir, raw_r} = String.split_at(l, 1)

      if dir == "L" do
        -String.to_integer(raw_r)
      else
        String.to_integer(raw_r)
      end
    end)
    |> Enum.reduce({50, 0}, fn r, {dial, result} ->
      new_dial = dial + r

      if rem(new_dial, 100) == 0 do
        {new_dial, result + 1}
      else
        {new_dial, result}
      end
    end)
    |> elem(1)
  end

  def part2(use_example) do
    parse_input(use_example)
    |> Enum.map(fn l ->
      {dir, raw_r} = String.split_at(l, 1)

      if dir == "L" do
        -String.to_integer(raw_r)
      else
        String.to_integer(raw_r)
      end
    end)
    |> Enum.reduce({50, 0}, fn r, {dial, result} ->
      new_dial = abs(dial + r)
      new_dial = if(new_dial >= 100, do: new_dial - 100, else: new_dial)

      new_result =
        result +
          abs(div(new_dial + 100 * sign(new_dial), 100) - div(dial, 100)) - 1

      # abs(div(new_dial + 100 * sign(new_dial), 100) - div(dial + 100 * sign(dial), 100)) -
      # 1

      # if(new_dial == 0 and new_dial != 0, do: 1, else: 0)

      # if((dial > 0 != new_dial > 0 and dial != 0) or new_dial == 0, do: 1, else: 0)

      {new_dial, new_result}
    end)
    |> elem(1)
  end

  def sign(n) when n < 0, do: -1
  def sign(n), do: 1

  def bool_to_int(true), do: 1
  def bool_to_int(false), do: 0

  def parse_input(use_example) do
    filename = if use_example, do: "example-input.txt", else: "input.txt"

    filename
    |> File.read!()
    |> String.split("\n", trim: true)
  end
end
