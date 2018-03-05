defmodule ExAch.Field do
  @moduledoc false

  @type t :: %__MODULE__{}

  defstruct [:name, :content, :length, :position, :required]

  @spec create(Keyword.t()) :: %__MODULE__{}
  def create(param) do
    %__MODULE__{
      name: Keyword.get(param, :name),
      content: Keyword.get(param, :content),
      length: Keyword.get(param, :length),
      position: Keyword.get(param, :position),
      required: Keyword.get(param, :required, true)
    }
  end
end
