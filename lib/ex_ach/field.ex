defmodule ExAch.Field do
  defmacro __using__(opts) do
    specifications = Keyword.get(opts, :specifications, [])
    value = Keyword.get(opts, :value)

    quote do
      import ExAch.Field
      defstruct [:content]

      @type t :: %__MODULE__{}

      def specifications do
        Enum.map(unquote(specifications), fn {key, specification} ->
          {field_name(__MODULE__), key, specification}
        end)
      end

      def new(content) do
        errors = ExAch.FieldValidator.validate(content, specifications())

        if Enum.empty?(errors) do
          {:ok, %__MODULE__{content: content}}
        else
          {:error, errors}
        end
      end

      def new do
        %__MODULE__{content: unquote(value)}
      end
    end
  end

  def field_name(module) do
    module
    |> to_string
    |> String.split(".")
    |> List.last()
    |> Macro.underscore()
    |> String.to_existing_atom()
  end

  def value(field) do
    field.content
  end
end
