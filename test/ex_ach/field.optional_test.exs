defmodule ExAch.Field.OptionalTest do
  use ExUnit.Case

  alias ExAch.File.Header.Fields.ImmediateDestination
  alias ExAch.Field

  describe "creating an optional" do
    test "a given type get stored in the optional" do
      optional = Field.Optional.new(ImmediateDestination)
      assert optional.field == ImmediateDestination
    end

    test "an optional field returns a nil value" do
      optional = Field.Optional.new(ImmediateDestination)
      assert is_nil(Field.value(optional))
    end
  end
end
