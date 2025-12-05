defmodule Day5 do
  def part1(use_example) do
    {ranges, ids} = parse_input(use_example)

    ids
    |> Enum.filter(fn id ->
      ranges
      |> Enum.any?(fn from..to//_ ->
        from <= id and id <= to
      end)
    end)
    |> length()
  end

  def part2(use_example) do
    {ranges, _} = parse_input(use_example)

    ranges
    |> Enum.reduce([], fn from..to//_, acc ->
      cond do
        acc == [] ->
          [from..to]

        true ->
          found = acc |> Enum.filter(fn r -> not Range.disjoint?(r, from..to) end)

          case found do
            [] ->
              [from..to | acc]

            [from2..to2//_ = r2] ->
              acc
              |> Enum.map(fn
                ^r2 -> min(from, from2)..max(to, to2)
                r -> r
              end)

            [from1..to1//_ = r1, from2..to2//_ = r2] ->
              combined = min(min(from2, from1), from)..max(max(to2, to1), to)

              acc
              |> Enum.reduce([], fn
                ^r1, acc -> acc
                ^r2, acc -> [combined | acc]
                r, acc -> [r | acc]
              end)
          end
      end
    end)
    |> Enum.map(fn r -> Range.size(r) end)
    |> Enum.sum()
  end

  def parse_input(use_example) do
    filename = if use_example, do: "example-input.txt", else: "input.txt"

    [ranges, ids] =
      filename
      |> File.read!()
      |> String.split("\n\n", trim: true)

    parsed_ranges =
      ranges
      |> String.split("\n", trim: true)
      |> Enum.map(fn r ->
        [from, to] =
          r
          |> String.split("-", trim: true)
          |> Enum.map(&String.to_integer/1)

        from..to
      end)

    parsed_ids =
      ids
      |> String.split("\n", trim: true)
      |> Enum.map(&String.to_integer/1)

    {parsed_ranges, parsed_ids}
  end
end
