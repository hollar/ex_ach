defmodule ExAch.BatchTest do
  use ExAch.TestCase

  alias ExAch.{Field, Batch, BatchHeader}

  setup do
    batch_header_params = %{
      company_name: "CompanyName",
      company_discretionary_data: "some optional data",  #TODO: no need to pass, as it's optional
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

    assert is_type_of?(batch.header, BatchHeader)
    assert is_type_of?(batch.header.record_type_code, Field)
    assert batch.header.record_type_code.content == "5"
    assert batch.header.record_type_code.position == 1
    assert batch.header.record_type_code.length == 1
    assert batch.header.record_type_code.required == true
  end

  test "add service_class_code", %{batch_header_params: batch_header_params, batch: batch} do
    {:ok, batch} = Batch.add_header(batch, batch_header_params)

    assert is_type_of?(batch.header.service_class_code, Field)
    assert batch.header.service_class_code.content == "220" # TODO: Check value
    assert batch.header.service_class_code.position == 2
    assert batch.header.service_class_code.length == 3
    assert batch.header.service_class_code.required == true
  end

  test "add company_name", %{batch_header_params: batch_header_params, batch: batch} do
    batch_header_params = Map.merge(batch_header_params, %{company_name: "123456789a123456"})
    {:ok, batch} = Batch.add_header(batch, batch_header_params)

    assert is_type_of?(batch.header.company_name, Field)
    assert batch.header.company_name.content == "123456789a123456"
    assert batch.header.company_name.position == 5
    assert batch.header.company_name.length == 16
    assert batch.header.company_name.required == true
  end

  test "add company_discretionary_data", %{batch_header_params: batch_header_params, batch: batch} do
    batch_header_params = Map.merge(batch_header_params, %{company_discretionary_data: "some data"})
    {:ok, batch} = Batch.add_header(batch, batch_header_params)

    assert is_type_of?(batch.header.company_discretionary_data, Field)
    assert batch.header.company_discretionary_data.content == "some data"
    assert batch.header.company_discretionary_data.position == 21
    assert batch.header.company_discretionary_data.length == 20
    assert batch.header.company_discretionary_data.required == false
  end

  test "add company_identification", %{batch_header_params: batch_header_params, batch: batch} do
    batch_header_params = Map.merge(batch_header_params, %{company_identification: "0123456789"})
    {:ok, batch} = Batch.add_header(batch, batch_header_params)

    assert is_type_of?(batch.header.company_identification, Field)
    assert batch.header.company_identification.content == "0123456789"
    assert batch.header.company_identification.position == 41
    assert batch.header.company_identification.length == 10
    assert batch.header.company_identification.required == true
  end

  test "add standard_entry_class_code", %{batch_header_params: batch_header_params, batch: batch} do
    batch_header_params = Map.merge(batch_header_params, %{standard_entry_class_code: "CCD"}) #TODO: check value
    {:ok, batch} = Batch.add_header(batch, batch_header_params)

    assert is_type_of?(batch.header.standard_entry_class_code, Field)
    assert batch.header.standard_entry_class_code.content == "CCD"
    assert batch.header.standard_entry_class_code.position == 51
    assert batch.header.standard_entry_class_code.length == 3
    assert batch.header.standard_entry_class_code.required == true
  end

  test "add company_entry_description", %{batch_header_params: batch_header_params, batch: batch} do
    batch_header_params = Map.merge(batch_header_params, %{company_entry_description: "PAY RES 3"})
    {:ok, batch} = Batch.add_header(batch, batch_header_params)

    assert is_type_of?(batch.header.company_entry_description, Field)
    assert batch.header.company_entry_description.content == "PAY RES 3"
    assert batch.header.company_entry_description.position == 54
    assert batch.header.company_entry_description.length == 10
    assert batch.header.company_entry_description.required == true
  end

  test "add company_descriptive_date", %{batch_header_params: batch_header_params, batch: batch} do
    batch_header_params = Map.merge(batch_header_params, %{company_descriptive_date: "170101"})
    {:ok, batch} = Batch.add_header(batch, batch_header_params)

    assert is_type_of?(batch.header.company_descriptive_date, Field)
    assert batch.header.company_descriptive_date.content == "170101"
    assert batch.header.company_descriptive_date.position == 64
    assert batch.header.company_descriptive_date.length == 6
    assert batch.header.company_descriptive_date.required == false
  end

  test "add effective_entry_date", %{batch_header_params: batch_header_params, batch: batch} do
    batch_header_params = Map.merge(batch_header_params, %{effective_entry_date: "170101"})
    {:ok, batch} = Batch.add_header(batch, batch_header_params)

    assert is_type_of?(batch.header.effective_entry_date, Field)
    assert batch.header.effective_entry_date.content == "170101"
    assert batch.header.effective_entry_date.position == 70
    assert batch.header.effective_entry_date.length == 6
    assert batch.header.effective_entry_date.required == true
  end

  test "add settlement_date", %{batch_header_params: batch_header_params, batch: batch} do
    batch_header_params = Map.merge(batch_header_params, %{settlement_date: ""})
    {:ok, batch} = Batch.add_header(batch, batch_header_params)

    assert is_type_of?(batch.header.settlement_date, Field)
    assert batch.header.settlement_date.content == ""
    assert batch.header.settlement_date.position == 76
    assert batch.header.settlement_date.length == 3
    assert batch.header.settlement_date.required == true
  end

  test "add originator_status_code", %{batch_header_params: batch_header_params, batch: batch} do
    {:ok, batch} = Batch.add_header(batch, batch_header_params)

    assert is_type_of?(batch.header.originator_status_code, Field)
    assert batch.header.originator_status_code.content == "1"
    assert batch.header.originator_status_code.position == 79
    assert batch.header.originator_status_code.length == 1
    assert batch.header.originator_status_code.required == true
  end

  test "add originating_dfi_identification", %{batch_header_params: batch_header_params, batch: batch} do
    batch_header_params = Map.merge(batch_header_params, %{originating_dfi_identification: "07100050"})
    {:ok, batch} = Batch.add_header(batch, batch_header_params)

    assert is_type_of?(batch.header.originating_dfi_identification, Field)
    assert batch.header.originating_dfi_identification.content == "07100050"
    assert batch.header.originating_dfi_identification.position == 80
    assert batch.header.originating_dfi_identification.length == 8
    assert batch.header.originating_dfi_identification.required == true
  end

  test "add batch_number", %{batch_header_params: batch_header_params, batch: batch} do
    batch_header_params = Map.merge(batch_header_params, %{batch_number: "1234567"})
    {:ok, batch} = Batch.add_header(batch, batch_header_params)

    assert is_type_of?(batch.header.batch_number, Field)
    assert batch.header.batch_number.content == "1234567"
    assert batch.header.batch_number.position == 88
    assert batch.header.batch_number.length == 7
    assert batch.header.batch_number.required == true
  end
end
