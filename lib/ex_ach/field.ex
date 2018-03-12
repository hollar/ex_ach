defmodule ExAch.Field do
  defmacro __using__(opts) do
    specifications = Keyword.get(opts, :specifications, [])
    default_content = Keyword.get(opts, :default_content)

    quote do
      import ExAch.Field
      defstruct [:content]

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
        %__MODULE__{content: unquote(default_content)}
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
