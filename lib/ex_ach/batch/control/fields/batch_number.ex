defmodule ExAch.Batch.Control.Fields.BatchNumber do
  @moduledoc """
  Number batches sequentially.
  """

  use ExAch.Field
  alias ExAch.Batch.Header.Fields.BatchNumber

  @spec new(BatchNumber.t()) :: t()
  def new(%BatchNumber{content: number}), do: %__MODULE__{content: number}
end
