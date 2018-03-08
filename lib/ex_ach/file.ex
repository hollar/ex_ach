defmodule ExAch.File do
  defstruct [:header, :batches]

  alias ExAch.{File, Batch}

  @type t :: %__MODULE__{}

  @doc """
  Create new File structure
  """
  @spec new(File.Header.t, [Batch.t]) :: {:ok, t}
  def new(%File.Header{} = header, batches) when is_list(batches) do
    {:ok, %__MODULE__{header: header, batches: batches}}
  end
end
