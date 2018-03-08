defmodule ExAch.FieldTest do
  use ExUnit.Case

  defmodule DummyField do
    use ExAch.Field, default_content: 5, specifications: [type: :integer, length: 1]
  end

  setup_all do
    :dummy_field

    :ok
  end

  describe "validating content" do
    {:error, errors} = DummyField.new("12")
    assert is_list(errors)
    assert Enum.count(errors) == 2
  end

  describe "creating a constructor with default value" do
    test "constructor created successfully" do
      %DummyField{content: 5} = DummyField.new()
    end
  end
end
