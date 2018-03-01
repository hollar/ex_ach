defmodule ExAch.Field do
  defstruct [:name, :content, :length, :position, :is_mandatory]

  def create(params) do
    %__MODULE__{
      name: Keyword.get(params, :name),
      content: Keyword.get(params, :content),
      length: Keyword.get(params, :length),
      position: Keyword.get(params, :position),
      is_mandatory: Keyword.get(params, :is_mandatory, true)
    }
  end
end
