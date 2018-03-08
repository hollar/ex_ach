defmodule ExAch.Batch.Entry.Fields.Amount do
  @moduledoc """
  Transaction amount in dollars with two decimal places. Left zero fill if necessary. Enter 10 zeros
  for prenotes.
  """

  @type t :: %__MODULE__{}
  use ExAch.Field,
    specifications: [
      type: :integer,
      max_length: 10
    ]
end
