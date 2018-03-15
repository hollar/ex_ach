defmodule ExAch.File.Control.Fields.RecordTypeCode do
  @moduledoc """
  The code identifying the File Control record is 9.
  """

  use ExAch.Field, value: "9", render: {:string, 1}
end
