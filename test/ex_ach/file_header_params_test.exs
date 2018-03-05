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

  describe "validating file header params" do
    setup do
      valid_params = %{
        immediate_destination: "b071000505",
        immediate_destination_name: "RBC ROYAL Bank",
        immediate_origin: "0123456789",
        immediate_origin_name: "ORIGIN Bank",
        file_creation_date: "180415",
        file_creation_time: "1205",
        file_id_modifier: "1",
        reference_code: "refcode"
      }
      [valid_params: valid_params]
    end

    test "valid header params", %{valid_params: valid_params} do
      file_header_params = FileHeaderParams.new(valid_params)
      assert FileHeaderParams.valid?(file_header_params)
      assert Vex.errors(file_header_params) == []
    end

    test "missing params value returns error", %{valid_params: valid_params} do
      fields =
        [
          :immediate_destination,
          :immediate_origin,
          :file_creation_date,
          :file_id_modifier,
          :reference_code
        ]
      Enum.map(fields,
        fn(field) ->
          missing_param_value = Map.merge(valid_params, %{field => nil})
          file_header_params = FileHeaderParams.new(missing_param_value)
          assert {:error, field, :presence, "must be present"} in Vex.errors(file_header_params)
          refute FileHeaderParams.valid?(file_header_params)
        end
      )
    end

    test "invalid immediate origin length returns error", %{valid_params: valid_params} do
      invalid_params = Map.merge(valid_params, %{immediate_origin: "123456789"})
      file_header_params = FileHeaderParams.new(invalid_params)
      expected_error = {:error, :immediate_origin, :length, "must have a length of 10"}

      assert expected_error in Vex.errors(file_header_params)
      refute FileHeaderParams.valid?(file_header_params)
    end

    test "invalid immediate origin format returns error", %{valid_params: valid_params} do
      invalid_params = Map.merge(valid_params, %{immediate_origin: "LETTER7890"})
      file_header_params = FileHeaderParams.new(invalid_params)
      expected_error = {:error, :immediate_origin, :format, "must have the correct format"}

      assert expected_error in Vex.errors(file_header_params)
      refute FileHeaderParams.valid?(file_header_params)
    end

    test "invalid immediate origin name length returns error", %{valid_params: valid_params} do
      invalid_params = Map.merge(valid_params, %{immediate_origin_name: "123456789012345678901234"})
      file_header_params = FileHeaderParams.new(invalid_params)
      expected_error =
        {:error, :immediate_origin_name, :length, "must have a length of no more than 23"}

      assert expected_error in Vex.errors(file_header_params)
      refute FileHeaderParams.valid?(file_header_params)
    end
  end
end
