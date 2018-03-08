defmodule ExAch.Batch.Header.Fields.RecordTypeCode do
  @moduledoc """
  The code identifying the Batch Header record is 5.
  """

  @type t :: %__MODULE__{}
  use ExAch.Field, default_content: 5
end
