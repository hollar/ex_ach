defmodule ExAch.File.Header.Fields.ImmediateOriginName do
  @moduledoc """
  Your company's name, up to 23 characters. This is an optional field.
  """

  @type t :: %__MODULE__{}
  use ExAch.Field, specifications: [type: :alpha_numeric, max_length: 23]
end
