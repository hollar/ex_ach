defmodule ExAch.Batch.Entry.Fields.Amount do
  @moduledoc """
  Transaction amount in dollars with two decimal places. Left zero fill if necessary. Enter 10 zeros
  for prenotes.
  """

  use ExAch.Field, validation: [type: :integer, max_length: 10], render: {:numeric, 10}
end
