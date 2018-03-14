defmodule ExAch.Batch.Entry.Fields.DiscretionaryData do
  @moduledoc """
  For your company's internal use if desired. No specific format is required
  """

  use ExAch.Field, validation: [type: :alphameric, max_length: 2]
end
