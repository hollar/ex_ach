defmodule ExAch.Field do
  defmacro __using__(opts) do
    specifications = Keyword.get(opts, :specifications, [])
    default_content = Keyword.get(opts, :default_content)

    quote do
      defstruct [:content]

      def specifications do
        field_name =
          __MODULE__
          |> to_string
          |> String.split(".")
          |> List.last()
          |> Macro.underscore()
          |> String.to_existing_atom()

        Enum.map(unquote(specifications), fn {key, specification} ->
          {field_name, key, specification}
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
end
