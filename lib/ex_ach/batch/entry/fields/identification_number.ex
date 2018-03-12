defmodule ExAch.Batch.Entry.Fields.IdentificationNumber do
  @moduledoc """
  Receiver's identification number.
  """

  @type t :: %__MODULE__{}
  use ExAch.Field,
    specifications: [
      type: :alpha_numeric,
      max_length: 15
    ]
end
