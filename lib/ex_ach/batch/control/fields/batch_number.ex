defmodule ExAch.Batch.Control.Fields.BatchNumber do
  @moduledoc """
  Number batches sequentially.
  """

  use ExAch.Field, render: {:numeric, 7}
end
