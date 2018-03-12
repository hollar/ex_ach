defmodule ExAch.Batch.Entry.Fields.ReceivingDfiIdentification do
  @moduledoc """
  Transit routing number of the receiver's financial institution.
  """

  @type t :: %__MODULE__{}
  use ExAch.Field,
    specifications: [
      type: :alpha_num_string,
      max_length: 8
    ]
end
