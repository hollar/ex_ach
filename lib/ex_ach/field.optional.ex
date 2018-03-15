defmodule ExAch.Field.Optional do
  defstruct [:field]

  @type t :: %__MODULE__{}

  @spec new(atom) :: t()
  def new(field_module) do
    %__MODULE__{field: field_module}
  end

  defimpl String.Chars, for: __MODULE__ do
    def to_string(optional_field) do
      optional_field.field.rendering_options
      |> render
    end

    defp render(:hhmm) do
      render({:string, 4})
    end

    defp render({:string, length}) do
      String.duplicate(" ", length)
    end
  end
end
