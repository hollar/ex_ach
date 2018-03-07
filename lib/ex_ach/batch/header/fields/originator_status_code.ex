defmodule ExAch.Batch.Header.Fields.OriginatorStatusCode do
  defstruct [:content]
  def new do
    %__MODULE__{content: 1}
  end
end
