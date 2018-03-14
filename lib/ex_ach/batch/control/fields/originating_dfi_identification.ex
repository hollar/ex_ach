defmodule ExAch.Batch.Control.Fields.OriginatingDfiIdentification do
  @moduledoc """
  Enter Bank routing transit number, for example Standard Federal’s transit routing number is
  07200080.
  """

  use ExAch.Field
  alias ExAch.Batch.Header.Fields.OriginatingDfiIdentification

  @spec new(OriginatingDfiIdentification.t()) :: t()
  def new(%OriginatingDfiIdentification{content: odfi}), do: %__MODULE__{content: odfi}
end
