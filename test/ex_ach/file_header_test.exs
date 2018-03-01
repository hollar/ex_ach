defmodule ExAch.FileHeaderTest do
  use ExUnit.Case

  alias ExAch.FileHeader

  describe "adding file header fields" do
    test "add record_type_code" do
      file_header =
        FileHeader.new()
        |> FileHeader.add_fields(%{})

      assert file_header.record_type_code.name == "Record Type Code"
      assert file_header.record_type_code.content == "1"
      assert file_header.record_type_code.length == 1
      assert file_header.record_type_code.position == {1, 1}
      assert file_header.record_type_code.is_mandatory == true
    end
  end
end
