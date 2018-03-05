defmodule ExAch.Batch do
  alias ExAch.BatchHeader
  defstruct [:header]

  def new do
    %__MODULE__{
    }
  end

  def add_header(batch, batch_header_params) do
    header = BatchHeader.new() |> BatchHeader.add_header(batch_header_params)

    {:ok, %{batch | header: header}}
  end
end
