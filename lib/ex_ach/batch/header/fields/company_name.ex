defmodule ExAch.Batch.Header.Fields.CompanyName do
  @moduledoc false

  defstruct [:content]

  @length 16
  @specifications [
    {:company_name, :format, ~r/^[0-9A-Za-z ]+$/},
    {:company_name, :max_length, @length}
  ]

  def new(content) do
    errors = ExAch.FieldValidator.validate(content, @specifications)

    if Enum.empty?(errors) do
      {:ok, %__MODULE__{content: content}}
    else
      {:error, errors}
    end
  end
end
