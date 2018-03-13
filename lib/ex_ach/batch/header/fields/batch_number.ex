defmodule ExAch.Batch.Header.Fields.BatchNumber do
  @moduledoc """
  Number batches sequentially.
  """

  use ExAch.Field,
    validation: [
      type: :integer,
      max_length: 7
    ]
end
