defmodule ExAch.Batch do
  alias ExAch.{BatchHeader, BatchHeaderParams}
  defstruct [:header]

  @type t :: %__MODULE__{}

  @spec new() :: t
  def new do
    %__MODULE__{}
  end

  @spec add_header(t, map) :: {:ok, t}
  def add_header(batch, batch_header_params) do
    header_params = BatchHeaderParams.new(batch_header_params)

    header =
      BatchHeader.new()
      |> BatchHeader.add_header(header_params)

    {:ok, %{batch | header: header}}
  end
end
