defmodule ExAch.Batch do
  alias ExAch.Batch
  defstruct [:header]

  @type t :: %__MODULE__{}

  @doc """
  Creates a new Batch Header structure
  """
  @spec new(Batch.Header.t()) :: {:ok, t}
  def new(%Batch.Header{} = header), do: {:ok, %__MODULE__{header: header}}
end
