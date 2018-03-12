defmodule ExAch.FieldTest do
  use ExUnit.Case

  defmodule DummyField do
    use ExAch.Field, default_content: 5, specifications: [type: :integer, length: 1]
  end

  describe "building the field name" do
    test "uses the module name" do
      assert ExAch.Field.field_name(DummyField) == :dummy_field
    end
  end

  describe "validating content" do
    test "returns errors" do
      {:error, errors} = DummyField.new("12")
      assert is_list(errors)
      assert Enum.count(errors) == 2
    end
  end

  describe "creating a constructor with default value" do
    test "constructor created successfully" do
      %DummyField{content: 5} = DummyField.new()
    end
  end
end
