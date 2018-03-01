defmodule ExAch.Ach do
  defstruct [:file_header]

  def new, do: %__MODULE__{}
end
