defmodule ExAch.File.Header.Fields.FormatCode do
  @moduledoc """
  Currently there is only 1 code. Enter 1.
  """

  @type t :: %__MODULE__{}
  use ExAch.Field, value: 1
end
