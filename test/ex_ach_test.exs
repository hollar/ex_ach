defmodule ExAchTest do
  use ExAch.TestCase

  doctest ExAch

  alias ExAch.{FileHeader, Field}

  describe "creating an ACH record" do
    setup do
      file_header_params = %{
        immediate_destination: "b071000505",
        immediate_destination_name: "RBC ROYAL Bank",
        immediate_origin: "0123456789",
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
      {:ok, ach} = ExAch.add_file_header(ExAch.new(), file_header_params)

      assert is_type_of?(ach.file_header, FileHeader)
      assert is_type_of?(ach.file_header.record_type_code, Field)
    end

    test "invalid file header params returns error", %{file_header_params: file_header_params} do
      invalid_file_header_params = Map.merge(file_header_params, %{immediate_destination: nil})
      result = ExAch.add_file_header(ExAch.new(), invalid_file_header_params)

      assert :error == elem(result, 0)
      assert {:error, :immediate_destination, :presence, "must be present"} in elem(result, 1)
    end

    test "adds a batch header fields" do
      batch = ExAch.Batch.new()
      {:ok, ach} = ExAch.add_batch(ExAch.new(), batch)
      assert Enum.count(ach.batches) == 1
    end

    test "add two batches" do
      batch = ExAch.Batch.new()
      ach = ExAch.new()
      {:ok, ach} = ExAch.add_batch(ach, batch)
      {:ok, ach} = ExAch.add_batch(ach, batch)

      assert Enum.count(ach.batches) == 2
    end
  end
end
