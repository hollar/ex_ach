defmodule ExAch do
  @moduledoc """
  ExAch is a library to generate a formatted ACH string.
  """

  alias ExAch.{Ach, FileHeader, FileHeaderParams}

  def new, do: Ach.new()

  def add_file_header(ach, file_header_params) do
    file_header_params_struct = FileHeaderParams.new(file_header_params)

    case FileHeaderParams.valid?(file_header_params_struct) do
      true ->
        file_header = FileHeader.add_fields(FileHeader.new(), file_header_params_struct)
        {:ok, %{ach | file_header: file_header}}

      false -> {:error, Vex.errors(file_header_params_struct)}
    end
  end
end
