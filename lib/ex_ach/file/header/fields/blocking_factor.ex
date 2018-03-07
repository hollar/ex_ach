defmodule ExAch.File.Header.Fields.BlockingFactor do
  defstruct [:content]
  def new do
    %__MODULE__{content: 10}
  end
end
