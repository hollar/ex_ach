defmodule ExAch.Batch.Control.Fields.OriginatingDfiIdentification do
  @moduledoc """
  Enter Bank routing transit number, for example Standard Federal’s transit routing number is
  07200080.
  """

  use ExAch.Field
  alias ExAch.Batch.Header.Fields.OriginatingDfiIdentification

  @spec new(OriginatingDfiIdentification.t()) :: {:ok, t()}
  def new(%OriginatingDfiIdentification{content: odfi}), do: {:ok, %__MODULE__{content: odfi}}
end
