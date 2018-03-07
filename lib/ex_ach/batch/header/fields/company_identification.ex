defmodule ExAch.Batch.Header.Fields.CompanyIdentification do
  @moduledoc """
  Your company name, up to 16 characters. This name may appear on the receivers’ statements
  prepared by the Receiving Financial Institution.
  """

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
