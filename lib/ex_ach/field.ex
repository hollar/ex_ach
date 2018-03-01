defmodule ExAch.Field do
  defstruct [:name, :content, :length, :position, :is_mandatory]

  def create(name, content, length, position, is_mandatory \\ true) do
    %__MODULE__{
      name: name,
      content: content,
      length: length,
      position: position,
      is_mandatory: is_mandatory
    }
  end
end
