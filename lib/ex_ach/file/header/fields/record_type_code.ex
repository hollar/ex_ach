defmodule ExAch.File.Header.Fields.RecordTypeCode do
  @moduledoc """
  The code identifying the File Header Record is 1.
  """

  @type t :: %__MODULE__{}
  use ExAch.Field, default_content: 1
end
