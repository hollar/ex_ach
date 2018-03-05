defmodule ExAch.BatchHeaderParamsTest do
  use ExUnit.Case

  alias ExAch.BatchHeaderParams

  describe "generating a new batch_header_params" do
    test "builds a new BatchHeaderParams" do
      params = %{
        company_name: "CompanyName",
        company_identification: "12345",
        company_discretionary_data: "some optional data",
        standard_entry_class_code: "WEB",
        company_entry_description: "DESC 1",
        company_descriptive_date: "180325",
        effective_entry_date: "180101",
        originating_dfi_identification: "12345678",
        batch_number: "0123456"
      }

      batch_header_params = BatchHeaderParams.new(params)

      assert batch_header_params.company_name == "CompanyName"
      assert batch_header_params.company_discretionary_data == "some optional data"
      assert batch_header_params.company_identification == "12345"
      assert batch_header_params.standard_entry_class_code == "WEB"
      assert batch_header_params.company_entry_description == "DESC 1"
      assert batch_header_params.company_descriptive_date == "180325"
      assert batch_header_params.effective_entry_date == "180101"
      assert batch_header_params.originating_dfi_identification == "12345678"
      assert batch_header_params.batch_number == "0123456"
    end
  end

  describe "validating batch header params" do
    setup do
      valid_params = %{
        company_name: "CompanyName",
        company_identification: "12345",
        company_discretionary_data: "some optional data",
        standard_entry_class_code: "WEB",
        company_entry_description: "DESC 1",
        company_descriptive_date: "180325",
        effective_entry_date: "180101",
        originating_dfi_identification: "12345678",
        batch_number: "0123456"
      }

      [valid_params: valid_params]
    end

    test "valid header params", %{valid_params: valid_params} do
      batch_header_params = BatchHeaderParams.new(valid_params)
      assert Vex.errors(batch_header_params) == []
      assert BatchHeaderParams.valid?(batch_header_params)
    end

    test "missing params value returns error", %{valid_params: valid_params} do
      fields = [
        :company_identification,
        :standard_entry_class_code,
        :company_entry_description,
        :effective_entry_date,
        :originating_dfi_identification,
        :batch_number
      ]

      Enum.map(fields, fn field ->
        missing_param_value = Map.merge(valid_params, %{field => nil})
        batch_header_params = BatchHeaderParams.new(missing_param_value)
        assert {:error, field, :presence, "must be present"} in Vex.errors(batch_header_params)
        refute BatchHeaderParams.valid?(batch_header_params)
      end)
    end

    test "invalid company_name length returns error", %{valid_params: valid_params} do
      invalid_params = Map.merge(valid_params, %{company_name: "long company name out of bound"})
      file_header_params = BatchHeaderParams.new(invalid_params)
      expected_error = {:error, :company_name, :length, "must have a length of no more than 16"}

      assert expected_error in Vex.errors(file_header_params)
      refute BatchHeaderParams.valid?(file_header_params)
    end

    test "invalid company_name characters returns error", %{valid_params: valid_params} do
      invalid_params = Map.merge(valid_params, %{company_name: "long_company name out of bound"})
      file_header_params = BatchHeaderParams.new(invalid_params)
      expected_error = {:error, :company_name, :format, "must have the correct format"}

      assert expected_error in Vex.errors(file_header_params)
      refute BatchHeaderParams.valid?(file_header_params)
    end
  end
end
