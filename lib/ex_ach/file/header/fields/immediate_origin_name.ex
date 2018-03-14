defmodule ExAch.File.Header.Fields.ImmediateOriginName do
  @moduledoc """
  Your company's name, up to 23 characters. This is an optional field.
  """

  use ExAch.Field, validation: [type: :alphameric, max_length: 23]
end
