defmodule ExAch.Field do
  defstruct [:name, :content, :length, :position, :required]

  def create(params) do
    %__MODULE__{
      name: Keyword.get(params, :name),
      content: Keyword.get(params, :content),
      length: Keyword.get(params, :length),
      position: Keyword.get(params, :position),
      required: Keyword.get(params, :required, true)
    }
  end
end
