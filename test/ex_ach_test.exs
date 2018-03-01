defmodule ExAchTest do
  use ExUnit.Case

  describe "creating an ACH record" do
    setup do
      file_header_params = %{
        immediate_destination: "b071000505",
        immediate_destination_name: "RBC ROYAL Bank",
        immediate_origin: "012345679",
        immediate_origin_name: "ORIGIN Bank",
        file_creation_date: "180415",
        file_creation_time: "1205",
        file_id_modifier: "1",
        reference_code: "refcode"
      }

      [file_header_params: file_header_params]
    end

    test "record created successfully", %{} do
      assert ExAch.new() == %ExAch.Ach{}
    end

    test "adds a file header with fields", %{file_header_params: file_header_params} do
      ach =
        ExAch.new()
        |> ExAch.add_file_header(file_header_params)

      assert is_type_of?(ach.file_header, ExAch.FileHeader)
      assert is_type_of?(ach.file_header.record_type_code, ExAch.Field)
    end
  end

  defp is_type_of?(struct, expected_struct) do
    struct.__struct__ == expected_struct
  end
end
