defmodule ExAch.Field do
  alias ExAch.Field

  defmacro __using__(opts) do
    validation = Keyword.get(opts, :validation, [])
    value = Keyword.get(opts, :value)
    rendering_options = Keyword.get(opts, :render, {:string, 0})

    quote do
      import ExAch.Field
      defstruct [:content, :render]

      @type t :: %__MODULE__{}

      def new(content) do
        errors = ExAch.FieldValidator.validate(content, validation_rules())

        if Enum.empty?(errors) do
          {:ok, %__MODULE__{content: content, render: unquote(rendering_options)}}
        else
          {:error, errors}
        end
      end

      def new do
        %__MODULE__{content: unquote(value), render: unquote(rendering_options)}
      end

      def copy(field) do
        {:ok, %__MODULE__{content: field.content, render: unquote(rendering_options)}}
      end

      defp validation_rules do
        Enum.map(unquote(validation), fn {key, rule} ->
          {field_name(__MODULE__), key, rule}
        end)
      end

      defoverridable new: 1, new: 0

      def rendering_options do
        unquote(rendering_options)
      end

      defimpl String.Chars, for: __MODULE__ do
        def to_string(field) do
          format = unquote(rendering_options)

          _ =
            field
            |> ExAch.Field.value()
            |> ExAch.Field.Renderer.render(format)
        end
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

  def value(%Field.Optional{}), do: nil

  def value(field) do
    field.content
  end

  def module(%{__struct__: module}), do: module
end
