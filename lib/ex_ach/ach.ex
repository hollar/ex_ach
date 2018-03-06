defmodule ExAch.Ach do
  @moduledoc false
  defstruct file_header: nil, batches: []

  @type t :: %__MODULE__{}

  @spec new :: t
  def new, do: %__MODULE__{}
end
