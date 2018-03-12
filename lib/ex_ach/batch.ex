defmodule ExAch.Batch do
  alias ExAch.Batch
  defstruct [:header, :entries]

  @type t :: %__MODULE__{}

  @doc """
  Creates a new Batch Header structure
  """
  @spec new(Batch.Header.t(), list(Batch.Entry.t())) :: {:ok, t}
  def new(%Batch.Header{} = header, batch_entries) do
    {:ok, %__MODULE__{header: header, entries: batch_entries}}
  end
end
