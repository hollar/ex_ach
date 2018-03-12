defmodule ExAch.Batch.Entry.Fields.CheckDigit do
  @moduledoc """
  The ninth digit of the receiving financial institution's transit routing number.
  """

  @type t :: %__MODULE__{}
  use ExAch.Field,
    specifications: [
      type: :integer,
      length: 1
    ]
end
