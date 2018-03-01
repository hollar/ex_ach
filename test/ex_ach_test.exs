defmodule ExAchTest do
  use ExUnit.Case

  describe "creating an ACH record" do
    test "record created successfully" do
      assert ExAch.new == %ExAch.Ach{}
    end
  end
end
