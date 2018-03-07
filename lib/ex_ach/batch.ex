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

    case BatchHeaderParams.valid?(header_params) do
      true ->
        header = BatchHeader.add_header(BatchHeader.new(), header_params)
        {:ok, %{batch | header: header}}

      false ->
        {:error, Vex.errors(header_params)}
    end
  end

  def new(header) do
    {:ok, %__MODULE__{header: header}}
  end
end
