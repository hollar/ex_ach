defmodule ExAch.File.Header.Fields.RecordTypeCode do
  @moduledoc """
  The code identifying the File Header Record is 1.
  """

  use ExAch.Field, value: 1, render: {:string, 1}
end
