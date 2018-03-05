defmodule ExAch do
  @moduledoc """
  ExAch is a library to generate a formatted ACH string.
  """

  alias ExAch.{Ach, FileHeader, FileHeaderParams}

  @type file_header_params :: %{
          immediate_destination: String.t(),
          immediate_destination_name: String.t(),
          immediate_origin: String.t(),
          immediate_origin_name: String.t(),
          file_creation_date: String.t(),
          file_creation_time: String.t(),
          file_id_modifier: String.t(),
          reference_code: String.t()
        }

  @doc """
  Create new ach file struct
  ## Examples

    iex> ExAch.new()
    %ExAch.Ach{}
  """
  @spec new :: Ach.t()
  def new, do: Ach.new()

  @doc """
  Add file header to ach
  """
  @spec add_file_header(Ach.t(), file_header_params) :: {:ok, Ach.t()} | {:error, [Tuple.t()]}
  def add_file_header(ach, file_header_params) do
    file_header_params_struct = FileHeaderParams.new(file_header_params)

    case FileHeaderParams.valid?(file_header_params_struct) do
      true ->
        file_header = FileHeader.add_fields(FileHeader.new(), file_header_params_struct)
        {:ok, %{ach | file_header: file_header}}

      false ->
        {:error, Vex.errors(file_header_params_struct)}
    end
  end

  def add_batch(ach, batch) do
    {:ok, %{ach | batches: [batch | ach.batches]}}
  end
end
