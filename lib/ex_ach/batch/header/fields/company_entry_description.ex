defmodule ExAch.Batch.Header.Fields.CompanyEntryDescription do
  @moduledoc """
  Your description of the transaction. This may be printed on the receivers’ bank statement by the
  Receiving Financial Institution. (i.e. Payroll)
  """

  defstruct [:content]

  @length 10
  @specifications [
    {:company_entry_description, :max_length, @length}
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
