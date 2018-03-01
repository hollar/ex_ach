defmodule ExAchTest do
  use ExUnit.Case
  doctest ExAch

  test "greets the world" do
    assert ExAch.hello() == :world
  end
end
