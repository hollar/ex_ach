defmodule ExAch.Batch.Header.Fields.CompanyIdentification do
  @moduledoc false

  defstruct [:content]

  @length 10
  @specifications [
    {:company_identification, :length, @length}
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
