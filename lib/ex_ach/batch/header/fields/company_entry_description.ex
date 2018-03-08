defmodule ExAch.Batch.Header.Fields.CompanyEntryDescription do
  @moduledoc """
  Your description of the transaction. This may be printed on the receivers’ bank statement by the
  Receiving Financial Institution. (i.e. Payroll).
  """

  use ExAch.Field, specifications: [
    type: :string,
    max_length: 10
  ]
end
