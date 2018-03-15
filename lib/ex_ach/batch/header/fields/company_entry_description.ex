defmodule ExAch.Batch.Header.Fields.CompanyEntryDescription do
  @moduledoc """
  Your description of the transaction. This may be printed on the receivers’ bank statement by the
  Receiving Financial Institution. (i.e. Payroll).
  """

  use ExAch.Field, validation: [type: :alphameric, max_length: 10], render: {:string, 10}
end
