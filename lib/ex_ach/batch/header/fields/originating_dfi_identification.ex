defmodule ExAch.Batch.Header.Fields.OriginatingDfiIdentification do
  @moduledoc """
  Enter Bank routing transit number, for example Standard Federal’s transit routing number is
  07200080.
  """

  use ExAch.Field, validation: [format: {~r/^\d{8}$/, "Must be 8 digits"}]
end
