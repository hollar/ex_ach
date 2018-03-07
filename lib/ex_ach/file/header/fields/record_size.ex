defmodule ExAch.File.Header.Fields.RecordSize do
  defstruct [:content]
  def new do
    %__MODULE__{content: "094"}
  end
end
