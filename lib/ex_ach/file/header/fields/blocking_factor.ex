defmodule ExAch.File.Header.Fields.BlockingFactor do
  @moduledoc """
  Block at 10
  """

  use ExAch.Field, value: 10, render: {:numeric, 2}
end
