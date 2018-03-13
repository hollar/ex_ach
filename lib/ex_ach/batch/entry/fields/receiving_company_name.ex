defmodule ExAch.Batch.Entry.Fields.ReceivingCompanyName do
  @moduledoc """
  Name of receiver
  """

  use ExAch.Field,
    specifications: [
      type: :alpha_numeric,
      max_length: 22
    ]
end
