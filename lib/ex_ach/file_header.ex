defmodule ExAch.FileHeader do
  alias ExAch.Field
  defstruct [:record_type_code]

  def new, do: %__MODULE__{}

  def add_fields(file_header, params) do
    file_header
    |> build_record_type_code
  end

  defp build_record_type_code(file_header) do
    field = Field.create("Record Type Code", "1", 1, {1, 1})

    %{file_header | record_type_code: field}
  end
end
