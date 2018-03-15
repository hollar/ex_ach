defmodule ExAch.Field.Renderer do
  @spec render(term, {atom, integer} | atom) :: String.t()
  def render(%Date{} = date, :yymmdd) do
    args = [rem(date.year, 100), date.month, date.day]
    sprintf("%02d%02d%02d", args)
  end

  def render(%Time{} = time, :hhmm) do
    args = [time.hour, time.minute]
    sprintf("%02d%02d", args)
  end

  def render(value, :bttttaaaa) do
    sprintf(" %9s", value)
  end

  def render(value, {:numeric, length}) do
    sprintf("%#{length}d", value)
  end

  def render(value, {:string, length}) do
    string = Kernel.to_string(value)
    sprintf("%-#{length}s", string)
  end

  defp sprintf(format, value) do
    list = List.wrap(value)
    ExPrintf.sprintf(format, list)
  end
end
