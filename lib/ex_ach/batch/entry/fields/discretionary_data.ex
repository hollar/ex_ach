defmodule ExAch.Batch.Entry.Fields.DiscretionaryData do
  @moduledoc """
  For your company's internal use if desired. No specific format is required
  """

  @type t :: %__MODULE__{}
  use ExAch.Field,
    specifications: [
      type: :alpha_numeric,
      max_length: 2
    ]
end
