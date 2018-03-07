defmodule ExAch.File.Header.Fields.PriorityCode do
  defstruct [:content]
  def new do
    %__MODULE__{content: "01"}
  end
end
