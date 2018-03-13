defmodule ExAch.Batch.Entry.Fields.DfiAccountNumber do
  @moduledoc """
  Receiver's account number at their financial institution. Left justify
  """

  use ExAch.Field,
    specifications: [
      type: :alpha_numeric,
      max_length: 17
    ]
end
