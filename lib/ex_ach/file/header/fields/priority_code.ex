defmodule ExAch.File.Header.Fields.PriorityCode do
  @moduledoc """
  The lower the number, the higher processing priority. Currently, only 01 is used.
  """

  @type t :: %__MODULE__{}
  use ExAch.Field, default_content: "01"
end
