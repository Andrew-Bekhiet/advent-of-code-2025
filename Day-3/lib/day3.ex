defmodule Day3 do
  def part1(use_example) do
    parse_input(use_example)
    |> Enum.map(fn bank ->
      len = length(bank)
      {max, max_i} = bank |> Enum.with_index() |> Enum.max_by(fn {j, _} -> j end)

      {left, right} =
        cond do
          max_i == len - 1 ->
            left = bank |> Enum.take(max_i) |> Enum.max()

            {left, max}

          true ->
            {_, rest} = bank |> Enum.split(max_i + 1)

            {max, Enum.max(rest)}
        end

      left * 10 + right
    end)
    |> Enum.sum()
  end

  def part2(use_example) do
    parse_input(use_example)
    |> Enum.map(fn bank ->
      max_possible_number(bank, length(bank), 12) |> Integer.undigits()
    end)
    |> Enum.sum()
  end

  def max_possible_number(_, _, 0), do: []

  def max_possible_number([], _, _), do: []

  def max_possible_number([d], _, _), do: [d]

  def max_possible_number(digits, _, 1), do: [Enum.max(digits)]

  def max_possible_number(digits, digits_length, required_digits_length)
      when digits_length <= required_digits_length, do: digits

  def max_possible_number(digits, digits_length, required_digits_length) do
    {max, max_i} = digits |> Enum.with_index() |> Enum.max_by(fn {j, _} -> j end)

    {left, right} = digits |> Enum.split(max_i + 1)

    right_length = digits_length - max_i - 1
    left_length = max_i + 1

    if right_length < required_digits_length do
      max_possible_number(
        left |> Enum.take(left_length - 1),
        left_length - 1,
        required_digits_length - right_length - 1
      ) ++ [max | right]
    else
      [max | max_possible_number(right, right_length, required_digits_length - 1)]
    end
  end

  def parse_input(use_example) do
    filename = if use_example, do: "example-input.txt", else: "input.txt"

    filename
    |> File.read!()
    |> String.split("\n", trim: true)
    |> Enum.map(fn bank ->
      bank |> String.graphemes() |> Enum.map(&String.to_integer/1)
    end)
  end
end
