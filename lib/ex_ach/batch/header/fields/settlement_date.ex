defmodule ExAch.Batch.Header.Fields.SettlementDate do
  defstruct [:content]

  def new do
    %__MODULE__{content: ""}
  end
end
