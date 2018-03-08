defmodule ExAch.Batch.Header.Fields.OriginatingDfiIdentification do
  @moduledoc """
  Enter Bank routing transit number, for example Standard Federal’s transit routing number is
  07200080.
  """

  @type t :: %__MODULE__{}
  use ExAch.Field, specifications: [type: :integer, max_length: 8]
end
