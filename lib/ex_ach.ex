defmodule ExAch do
  @moduledoc """
  Documentation for ExAch.
  """

  alias ExAch.{Ach, FileHeader}

  def new, do: Ach.new()

  def add_file_header(ach, params \\ %{}) do
    file_header =
      FileHeader.new()
      |> FileHeader.add_fields(params)

    %{ach | file_header: file_header}
  end
end
