defmodule ExAch.File.Header.Fields.BlockingFactor do
  @moduledoc """
  Block at 10
  """
  @type t :: %__MODULE__{}
  use ExAch.Field, default_content: 10
end
