defmodule ExAch.BatchTest do
  use ExAch.TestCase

  alias ExAch.{Field, Batch, BatchHeader}

  setup do
    batch_header_params = %{
      company_name: "CompanyName",
      company_identification: "some id",
      standard_entry_class_code: "WEB",
      company_entry_description: "DESC 1",
      company_descriptive_date: "180325",
      effective_entry_date: "180101",
      originating_dfi_identification: "12345678",
      batch_number: "0123456"
    }
    batch = Batch.new()
    [batch_header_params: batch_header_params, batch: batch]
  end

  test "record created successfully", %{} do
    assert Batch.new() == %Batch{}
  end

  test "add a batch header with fields", %{batch_header_params: batch_header_params, batch: batch} do
    {:ok, batch} = Batch.add_header(batch, batch_header_params)
    expected_result = %{content: "5", position: 1, length: 1, required: true}
    assert_field(batch.header, :record_type_code, expected_result)
  end

  test "add service_class_code", %{batch_header_params: batch_header_params, batch: batch} do
    {:ok, batch} = Batch.add_header(batch, batch_header_params)
    expected_result = %{content: "220", position: 2, length: 3, required: true} # TODO: Check value for content
    assert_field(batch.header, :service_class_code, expected_result)
  end

  test "add company_name", %{batch_header_params: batch_header_params, batch: batch} do
    batch_header_params = Map.merge(batch_header_params, %{company_name: "123456789a123456"})
    {:ok, batch} = Batch.add_header(batch, batch_header_params)

    expected_result = %{content: "123456789a123456", position: 5, length: 16, required: true}
    assert_field(batch.header, :company_name, expected_result)
  end

  test "add company_discretionary_data", %{batch_header_params: batch_header_params, batch: batch} do
    batch_header_params = Map.merge(batch_header_params, %{company_discretionary_data: "some data"})
    {:ok, batch} = Batch.add_header(batch, batch_header_params)

    expected_result = %{content: "some data", position: 21, length: 20, required: false}
    assert_field(batch.header, :company_discretionary_data, expected_result)
  end

  test "add company_identification", %{batch_header_params: batch_header_params, batch: batch} do
    batch_header_params = Map.merge(batch_header_params, %{company_identification: "0123456789"})
    {:ok, batch} = Batch.add_header(batch, batch_header_params)

    expected_result = %{content: "0123456789", position: 41, length: 10, required: true}
    assert_field(batch.header, :company_identification, expected_result)
  end

  test "add standard_entry_class_code", %{batch_header_params: batch_header_params, batch: batch} do
    batch_header_params = Map.merge(batch_header_params, %{standard_entry_class_code: "CCD"}) #TODO: check value
    {:ok, batch} = Batch.add_header(batch, batch_header_params)

    expected_result = %{content: "CCD", position: 51, length: 3, required: true}
    assert_field(batch.header, :standard_entry_class_code, expected_result)
  end

  test "add company_entry_description", %{batch_header_params: batch_header_params, batch: batch} do
    batch_header_params = Map.merge(batch_header_params, %{company_entry_description: "PAY RES 3"})
    {:ok, batch} = Batch.add_header(batch, batch_header_params)

    expected_result = %{content: "PAY RES 3", position: 54, length: 10, required: true}
    assert_field(batch.header, :company_entry_description, expected_result)
  end

  test "add company_descriptive_date", %{batch_header_params: batch_header_params, batch: batch} do
    batch_header_params = Map.merge(batch_header_params, %{company_descriptive_date: "170101"})
    {:ok, batch} = Batch.add_header(batch, batch_header_params)

    expected_result = %{content: "170101", position: 64, length: 6, required: false}
    assert_field(batch.header, :company_descriptive_date, expected_result)
  end

  test "add effective_entry_date", %{batch_header_params: batch_header_params, batch: batch} do
    batch_header_params = Map.merge(batch_header_params, %{effective_entry_date: "170101"})
    {:ok, batch} = Batch.add_header(batch, batch_header_params)

    expected_result = %{content: "170101", position: 70, length: 6, required: true}
    assert_field(batch.header, :effective_entry_date, expected_result)
  end

  test "add settlement_date", %{batch_header_params: batch_header_params, batch: batch} do
    batch_header_params = Map.merge(batch_header_params, %{settlement_date: ""})
    {:ok, batch} = Batch.add_header(batch, batch_header_params)

    expected_result = %{content: "", position: 76, length: 3, required: true}
    assert_field(batch.header, :settlement_date, expected_result)
  end

  test "add originator_status_code", %{batch_header_params: batch_header_params, batch: batch} do
    {:ok, batch} = Batch.add_header(batch, batch_header_params)

    expected_result = %{content: "1", position: 79, length: 1, required: true}
    assert_field(batch.header, :originator_status_code, expected_result)
  end

  test "add originating_dfi_identification", %{batch_header_params: batch_header_params, batch: batch} do
    batch_header_params = Map.merge(batch_header_params, %{originating_dfi_identification: "07100050"})
    {:ok, batch} = Batch.add_header(batch, batch_header_params)

    expected_result = %{content: "07100050", position: 80, length: 8, required: true}
    assert_field(batch.header, :originating_dfi_identification, expected_result)
  end

  test "add batch_number", %{batch_header_params: batch_header_params, batch: batch} do
    batch_header_params = Map.merge(batch_header_params, %{batch_number: "1234567"})
    {:ok, batch} = Batch.add_header(batch, batch_header_params)

    expected_result = %{content: "1234567", position: 88, length: 7, required: true}
    assert_field(batch.header, :batch_number, expected_result)
  end

  defp assert_field(header, field_name, expected_result) do
    assert is_type_of?(header, BatchHeader)

    field = Map.fetch!(header, field_name)

    assert is_type_of?(field, Field)
    assert field.content == expected_result.content
    assert field.position == expected_result.position
    assert field.length == expected_result.length
    assert field.required == expected_result.required
  end
end
