defmodule ExAchTest do
  use ExUnit.Case

  describe "creating an ACH record" do
    test "record created successfully" do
      assert ExAch.new() == %ExAch.Ach{}
    end

    test "adds a file header record" do
      ach = ExAch.add_file_header(ExAch.new())

      assert is_type_of?(ach.file_header, ExAch.FileHeader)
    end

    test "adds a file header with fields" do
      ach =
        ExAch.new()
        |> ExAch.add_file_header()

      assert is_type_of?(ach.file_header.record_type_code, ExAch.Field)
    end
  end

  defp is_type_of?(struct, expected_struct) do
    struct.__struct__ == expected_struct
  end
end
