defmodule ExAch.File.Header.Fields.RecordSize do
  @moduledoc """
  Number of bytes per record. Enter 094
  """
  use ExAch.Field, default_content: "094"
end
