defmodule ExAch.Batch.Entry.Fields.ReceivingDfiIdentification do
  @moduledoc """
  Transit routing number of the receiver's financial institution.
  """

  use ExAch.Field,
    validation: [
      type: :alpha_numeric,
      max_length: 8
    ]
end
