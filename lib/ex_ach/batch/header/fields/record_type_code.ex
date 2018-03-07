defmodule ExAch.Batch.Header.Fields.RecordTypeCode do
  defstruct [:content]
  def new do
    %__MODULE__{content: 5}
  end
end
