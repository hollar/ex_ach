defmodule ExAch.Batch do
  alias ExAch.{BatchHeader, BatchHeaderParams}
  defstruct [:header]

  def new do
    %__MODULE__{}
  end

  def add_header(batch, batch_header_params) do
    header_params = BatchHeaderParams.new(batch_header_params)

    header =
      BatchHeader.new()
      |> BatchHeader.add_header(header_params)

    {:ok, %{batch | header: header}}
  end
end
