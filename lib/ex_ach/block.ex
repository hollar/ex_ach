defmodule ExAch.Block do
  @filler_char "9"

  @spec fill(iodata, integer, integer, integer) :: iodata
  def fill(iodata, line_count, blocking_factor, record_size) do
    case filler_lines_to_add(line_count, blocking_factor) do
      0 ->
        iodata

      count ->
        filler_lines =
          Enum.map(Range.new(0, count - 1), fn _i ->
            String.duplicate(@filler_char, record_size)
          end)

        iodata ++ filler_lines
    end
  end

  defp filler_lines_to_add(line_count, blocking_factor) do
    rem(line_count, blocking_factor)
  end
end
