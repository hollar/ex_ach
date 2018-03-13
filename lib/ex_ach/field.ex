defmodule ExAch.Field do
  defmacro __using__(opts) do
    validation = Keyword.get(opts, :validation, [])
    value = Keyword.get(opts, :value)

    quote do
      import ExAch.Field
      defstruct [:content]

      @type t :: %__MODULE__{}

      def new(content) do
        errors = ExAch.FieldValidator.validate(content, validation_rules())

        if Enum.empty?(errors) do
          {:ok, %__MODULE__{content: content}}
        else
          {:error, errors}
        end
      end

      def new do
        %__MODULE__{content: unquote(value)}
      end

      defp validation_rules do
        Enum.map(unquote(validation), fn {key, rule} ->
          {field_name(__MODULE__), key, rule}
        end)
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
