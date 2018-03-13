defmodule ExAch.Batch.Entry.Fields.CheckDigit do
  @moduledoc """
  The ninth digit of the receiving financial institution's transit routing number.
  """

  use ExAch.Field,
    validation: [
      type: :integer,
      length: 1
    ]
end
