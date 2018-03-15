defmodule ExAch.Field.Optional do
  defstruct [:field]

  @type t :: %__MODULE__{}

  @spec new(atom) :: t()
  def new(field_module) do
    %__MODULE__{field: field_module}
  end
end
