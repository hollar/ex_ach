defmodule ExAch.Batch.Control.Fields.EntryHash do
  @moduledoc """
  """

  use ExAch.Field

  alias ExAch.Batch

  @type t :: %__MODULE__{}

  @spec new(list(Batch.Entry.t())) :: t()
  def new(entries) do
    sum =
      entries
      |> Enum.map(fn entry -> entry.receiving_dfi_identification.content end)
      |> Enum.sum()
      |> to_string
      |> String.split_at(-10)
      |> elem(1)
      |> String.to_integer()

    {:ok, %__MODULE__{content: sum}}
  end
end
