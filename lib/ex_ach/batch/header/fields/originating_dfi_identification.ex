defmodule ExAch.Batch.Header.Fields.OriginatingDfiIdentification do
  @moduledoc """
  Enter LaSalle’s routing transit number 07100050, or Standard Federal’s transit routing number of 07200080.
  """
  defstruct [:content]

  def new(content) do
    {:ok, %__MODULE__{content: content}}
  end


end
