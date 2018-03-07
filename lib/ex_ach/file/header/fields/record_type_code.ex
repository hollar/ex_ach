defmodule ExAch.File.Header.Fields.RecordTypeCode do
  defstruct [:content]

  def new do
    %__MODULE__{content: 1}
  end
end
