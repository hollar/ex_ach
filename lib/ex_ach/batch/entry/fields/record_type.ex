defmodule ExAch.Batch.Entry.Fields.RecordTypeCode do
  @moduledoc """
  The code identifying an Entry Detail Record is 6.
  """

  @type t :: %__MODULE__{}
  use ExAch.Field, value: 6
end
