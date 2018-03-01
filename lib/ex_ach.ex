defmodule ExAch do
  @moduledoc """
  ExAch is a library to generate a formatted ACH string.
  """

  alias ExAch.{Ach, FileHeader, FileHeaderParams}

  def new, do: Ach.new()

  def add_file_header(ach, file_header_params) do
    file_header_params = FileHeaderParams.new(file_header_params)

    file_header =
      FileHeader.new()
      |> FileHeader.add_fields(file_header_params)

    %{ach | file_header: file_header}
  end
end
