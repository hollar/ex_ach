defmodule ExAch.Batch.Header.Fields.CompanyEntryDescription do
  @moduledoc """
  Your description of the transaction. This may be printed on the receivers’ bank statement by the
  Receiving Financial Institution. (i.e. Payroll).
  """

  @type t :: %__MODULE__{}
  use ExAch.Field, specifications: [type: :alpha_numeric, max_length: 10]
end
