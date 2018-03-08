defmodule ExAch.Batch.Entry.Fields.DfiAccountNumber do
  @moduledoc """
  Receiver's account number at their financial institution. Left justify
  """

  @type t :: %__MODULE__{}
  use ExAch.Field,
    specifications: [
      type: :alpha_num_string,
      max_length: 17
    ]
end
