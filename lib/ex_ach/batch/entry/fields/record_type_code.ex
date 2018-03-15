defmodule ExAch.Batch.Entry.Fields.RecordTypeCode do
  @moduledoc """
  The code identifying an Entry Detail Record is 6.
  """

  use ExAch.Field, value: "6", render: {:string, 1}
end
