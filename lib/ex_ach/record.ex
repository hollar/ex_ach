defmodule ExAch.Record do
  defmacro __using__(_opts) do
    quote do
      import ExAch.Record
      alias ExAch.Field

      def assign_optional(opts, field_module) do
        field_name = Field.field_name(field_module)
        Keyword.get(opts, field_name, Field.Optional.new(field_module))
      end

      def reserved_field(length) do
        String.duplicate(" ", length)
      end
    end
  end
end
