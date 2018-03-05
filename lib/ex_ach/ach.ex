defmodule ExAch.Ach do
  @moduledoc false
  defstruct [:file_header]

  @spec new :: %__MODULE__{}
  def new, do: %__MODULE__{}
end
