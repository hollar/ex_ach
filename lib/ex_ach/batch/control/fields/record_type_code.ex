defmodule ExAch.Batch.Control.Fields.RecordTypeCode do
  @moduledoc """
  The code identifying the Batch Control record is 8.
  """

  @type t :: %__MODULE__{}
  use ExAch.Field, default_content: 8
end
