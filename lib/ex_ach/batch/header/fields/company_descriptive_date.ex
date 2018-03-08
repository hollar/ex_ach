defmodule ExAch.Batch.Header.Fields.CompanyDescriptiveDate do
  @moduledoc """
  The date you choose to identify the transaction. This date may be printed on the participants'
  bank statement by the Receiving Financial Institution.
  """

  @type t :: %__MODULE__{}
  use ExAch.Field, specifications: [type: :date]
end
