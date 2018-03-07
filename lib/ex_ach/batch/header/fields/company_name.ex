defmodule ExAch.Batch.Header.Fields.CompanyName do
  @moduledoc false

  defstruct [:content]

  @length 16

  def new(content) do
    errors =
      ExAch.FieldValidator.validate(content, [
            {:company_name, :format, ~r/^[0-9A-Za-z ]+$/},
            {:company_name, :length, @length}
          ])

    if Enum.empty?(errors) do
      {:ok, %__MODULE__{content: content}}
    else
      {:error, errors}
    end
  end
end
