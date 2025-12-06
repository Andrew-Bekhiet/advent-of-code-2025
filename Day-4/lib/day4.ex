defmodule Grid do
  @type t :: %__MODULE__{
          data: tuple(),
          width: integer(),
          height: integer()
        }
  defstruct [:data, :width, :height]

  def parse(input) do
    {data, width, height} =
      input
      |> String.split("\n", trim: true)
      |> Enum.reduce(
        {nil, 0, 0},
        fn
          line, {nil, 0, 0} ->
            {
              [
                line
                |> String.graphemes()
                |> List.to_tuple()
              ],
              String.length(line),
              1
            }

          line, {data, width, height} ->
            new_data =
              line
              |> String.graphemes()
              |> List.to_tuple()

            {[new_data | data], width, height + 1}
        end
      )

    %Grid{
      data: data |> Enum.reverse() |> List.to_tuple(),
      width: width,
      height: height
    }
  end

  def at(%Grid{}, {nil, _}), do: nil
  def at(%Grid{}, {_, nil}), do: nil

  def at(%Grid{width: width, height: height}, {x, y})
      when x < 0 or x >= width or y < 0 or y >= height,
      do: nil

  def at(%Grid{data: data}, {x, y}) do
    data |> elem(y) |> elem(x)
  end

  def has(%Grid{}, {nil, _}), do: false
  def has(%Grid{}, {_, nil}), do: false

  def has(%Grid{width: width, height: height}, {x, y}),
    do: x >= 0 and x < width and y >= 0 and y < height
end

defmodule Day4 do
  def remove_reachable_paper(%Grid{width: width, height: height} = grid) do
    {new_data, removed} =
      0..(height - 1)
      |> Enum.reduce({[], 0}, fn y, {new_data, count} ->
        {new_line, sum} =
          0..(width - 1)
          |> Enum.reduce({[], 0}, fn x, {new_line, count} ->
            char = grid |> Grid.at({x, y})

            cond do
              char != "@" ->
                {["." | new_line], count}

              [
                {x, y + 1},
                {x, y - 1},
                {x + 1, y},
                {x - 1, y},
                {x + 1, y + 1},
                {x + 1, y - 1},
                {x - 1, y + 1},
                {x - 1, y - 1}
              ]
              |> Enum.filter(fn {x, y} ->
                x >= 0 and x < width and y >= 0 and y < height and
                    Grid.at(grid, {x, y}) == "@"
              end)
              |> Enum.take(4)
              |> length() < 4 ->
                {["." | new_line], count + 1}

              true ->
                {["@" | new_line], count}
            end
          end)

        {[new_line |> List.to_tuple() | new_data], sum + count}
      end)

    {%Grid{data: new_data |> List.to_tuple(), width: width, height: height}, removed}
  end

  def remove_all_reachable_paper(%Grid{} = grid, removed) do
    {new_grid, new_removed} = remove_reachable_paper(grid)

    if new_removed == 0 do
      removed
    else
      removed + remove_all_reachable_paper(new_grid, new_removed)
    end
  end

  def part1(use_example) do
    grid = parse_input(use_example)

    {_, removed} = remove_reachable_paper(grid)

    removed
  end

  def part2(use_example) do
    grid = parse_input(use_example)

    removed = remove_all_reachable_paper(grid, -1)

    removed + 1
  end

  def parse_input(use_example) do
    filename = if use_example, do: "example-input.txt", else: "input.txt"

    filename
    |> File.read!()
    |> Grid.parse()
  end
end
