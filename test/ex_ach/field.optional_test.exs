defmodule ExAch.Field.OptionalTest do
  use ExUnit.Case

  alias ExAch.File.Header.Fields.ReferenceCode
  alias ExAch.Field

  describe "creating an optional" do
    test "a given type get stored in the optional" do
      optional = Field.Optional.new(ReferenceCode)
      assert optional.field == ReferenceCode
    end

    test "an optional field returns a nil value" do
      optional = Field.Optional.new(ReferenceCode)
      assert is_nil(Field.value(optional))
    end
  end

  describe "rendering the value" do
    test "type provides the format to use for building the string" do
      optional = Field.Optional.new(ReferenceCode)
      string = to_string(optional)
      assert string == "        "
    end
  end
end
