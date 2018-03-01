defmodule ExAch.FileHeaderParamsTest do
  use ExUnit.Case

  alias ExAch.FileHeaderParams

  describe "generating a new file_header_params" do
    test "builds a new FileHeaderParams" do
      params = %{
        immediate_destination: "b071000505",
        immediate_destination_name: "RBC ROYAL Bank",
        immediate_origin: "012345679",
        immediate_origin_name: "ORIGIN Bank",
        file_creation_date: "180415",
        file_creation_time: "1205",
        file_id_modifier: "1",
        reference_code: "refcode"
      }

      file_header_params = FileHeaderParams.new(params)

      assert file_header_params.immediate_destination == "b071000505"
      assert file_header_params.immediate_destination_name == "RBC ROYAL Bank"
      assert file_header_params.immediate_origin == "012345679"
      assert file_header_params.immediate_origin_name == "ORIGIN Bank"
      assert file_header_params.file_creation_date == "180415"
      assert file_header_params.file_creation_time == "1205"
      assert file_header_params.file_id_modifier == "1"
      assert file_header_params.reference_code == "refcode"
    end
  end
end
