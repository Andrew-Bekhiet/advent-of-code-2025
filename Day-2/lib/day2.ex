defmodule Day2 do
  def part1(use_example) do
    parse_input(use_example)
    |> Enum.map(fn range ->
      range
      |> Range.to_list()
      |> Enum.filter(fn n ->
        digits = Integer.digits(n)
        {p1, p2} = digits |> Enum.split(digits |> length() |> div(2))

        p1 == p2
      end)
      |> Enum.sum()
    end)
    |> Enum.sum()
  end

  def part2(use_example) do
    parse_input(use_example)
    |> Enum.map(fn range ->
      range
      |> Range.to_list()
      |> Enum.filter(fn n ->
        digits = Integer.digits(n)
        len = length(digits)

        if len < 2 do
          false
        else
          2..len
          |> Range.to_list()
          |> Enum.any?(fn d ->
            count = div(len, d)

            [head | tail] = digits |> Enum.chunk_every(count)

            tail |> Enum.all?(&(&1 == head))
          end)
        end
      end)
      |> Enum.sum()
    end)
    |> Enum.sum()
  end

  def parse_input(use_example) do
    filename = if use_example, do: "example-input.txt", else: "input.txt"

    filename
    |> File.read!()
    |> String.split("\n", trim: true)
    |> Enum.at(0)
    |> String.split(",", trim: true)
    |> Enum.map(fn range ->
      [from, to] =
        range
        |> String.split("-", trim: true)
        |> Enum.map(&String.to_integer/1)

      from..to
    end)
  end
end
