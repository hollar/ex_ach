defmodule ExAch.TestCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      import ExAch.TestCase
    end
  end

  def is_type_of?(struct, expected_struct) do
    struct.__struct__ == expected_struct
  end
end
