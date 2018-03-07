defmodule ExAch.Batch.Header.Fields.StandardEntryClassCode do
  @moduledoc """
  Identifies the entries in the batch.

  Common standard entry class codes are PPD (Prearranged Payments and Deposit entries) for consumer
  items, CCD (Cash Concentration and Disbursement entries), CTX (Corporate Trade Exchange entries)
  for corporate transactions, TEL (Telephone initiated entries), and WEB (Authorization received
  via the Internet).
  """

  defstruct [:content]

  @length 10
  @rules [
    {:standard_entry_class_code, :inclusion, [:web, :ccd, :ppd, :ctx, :tel, :web]}
  ]

  def new(content) do
    errors = ExAch.FieldValidator.validate(content, @rules)

    if Enum.empty?(errors) do
      {:ok, %__MODULE__{content: content}}
    else
      {:error, errors}
    end
  end
end
