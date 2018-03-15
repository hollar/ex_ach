defmodule ExAch.File.Header.Fields.RecordSize do
  @moduledoc """
  Number of bytes per record. Enter 094
  """

  use ExAch.Field, value: 94, render: {:numeric, 3}
end
