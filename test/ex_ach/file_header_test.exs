defmodule ExAch.FileHeaderTest do
  use ExUnit.Case

  alias ExAch.FileHeader

  describe "adding file header fields" do
    setup do
      params = %{
        immediate_destination: "b071000505",
        immediate_origin: "012345679",
        file_creation_date: "180415",
        file_id_modifier: "1",
        reference_code: "refcode"
      }

      [file_header: FileHeader.new(), params: params]
    end

    test "add record_type_code", %{file_header: new_file_header, params: params} do
      file_header = FileHeader.add_fields(new_file_header, params)

      assert file_header.record_type_code.name == :record_type_code
      assert file_header.record_type_code.content == "1"
      assert file_header.record_type_code.length == 1
      assert file_header.record_type_code.position == 1
      assert file_header.record_type_code.required == true
    end

    test "add priority_code", %{file_header: new_file_header, params: params} do
      file_header = FileHeader.add_fields(new_file_header, params)

      assert file_header.priority_code.name == :priority_code
      assert file_header.priority_code.content == "01"
      assert file_header.priority_code.length == 2
      assert file_header.priority_code.position == 2
      assert file_header.priority_code.required == true
    end

    test "add immediate_destination", %{file_header: new_file_header, params: params} do
      content = "b071000505"
      updated_params = Map.merge(params, %{immediate_destination: content})
      file_header = FileHeader.add_fields(new_file_header, updated_params)

      assert file_header.immediate_destination.name == :immediate_destination
      assert file_header.immediate_destination.content == content
      assert file_header.immediate_destination.length == 10
      assert file_header.immediate_destination.position == 4
      assert file_header.immediate_destination.required == true
    end

    test "add immediate_origin", %{file_header: new_file_header, params: params} do
      content = "012345679"
      updated_params = Map.merge(params, %{immediate_origin: content})
      file_header = FileHeader.add_fields(new_file_header, updated_params)

      assert file_header.immediate_origin.name == :immediate_origin
      assert file_header.immediate_origin.content == content
      assert file_header.immediate_origin.length == 10
      assert file_header.immediate_origin.position == 14
      assert file_header.immediate_origin.required == true
    end

    test "add file_creation_date", %{file_header: new_file_header, params: params} do
      content = "180325"
      updated_params = Map.merge(params, %{file_creation_date: content})
      file_header = FileHeader.add_fields(new_file_header, updated_params)

      assert file_header.file_creation_date.name == :file_creation_date
      assert file_header.file_creation_date.content == content
      assert file_header.file_creation_date.length == 6
      assert file_header.file_creation_date.position == 24
      assert file_header.file_creation_date.required == true
    end

    test "add file_creation_time", %{file_header: new_file_header, params: params} do
      content = "1103"
      updated_params = Map.merge(params, %{file_creation_time: content})
      file_header = FileHeader.add_fields(new_file_header, updated_params)

      assert file_header.file_creation_time.name == :file_creation_time
      assert file_header.file_creation_time.content == content
      assert file_header.file_creation_time.length == 4
      assert file_header.file_creation_time.position == 30
      assert file_header.file_creation_time.required == false
    end

    test "add file_id_modifier", %{file_header: new_file_header, params: params} do
      content = "3"
      updated_params = Map.merge(params, %{file_id_modifier: content})
      file_header = FileHeader.add_fields(new_file_header, updated_params)

      assert file_header.file_id_modifier.name == :file_id_modifier
      assert file_header.file_id_modifier.content == content
      assert file_header.file_id_modifier.length == 1
      assert file_header.file_id_modifier.position == 34
      assert file_header.file_id_modifier.required == true
    end

    test "add record_size", %{file_header: new_file_header, params: params} do
      file_header = FileHeader.add_fields(new_file_header, params)

      assert file_header.record_size.name == :record_size
      assert file_header.record_size.content == "094"
      assert file_header.record_size.length == 3
      assert file_header.record_size.position == 35
      assert file_header.record_size.required == true
    end

    test "add blocking_factor", %{file_header: new_file_header, params: params} do
      file_header = FileHeader.add_fields(new_file_header, params)

      assert file_header.blocking_factor.name == :blocking_factor
      assert file_header.blocking_factor.content == "10"
      assert file_header.blocking_factor.length == 2
      assert file_header.blocking_factor.position == 38
      assert file_header.blocking_factor.required == true
    end

    test "add format_code", %{file_header: new_file_header, params: params} do
      file_header = FileHeader.add_fields(new_file_header, params)

      assert file_header.format_code.name == :format_code
      assert file_header.format_code.content == "1"
      assert file_header.format_code.length == 1
      assert file_header.format_code.position == 40
      assert file_header.format_code.required == true
    end

    test "add immediate_destination_name", %{file_header: new_file_header, params: params} do
      content = "LaSalle Bank N.A"
      updated_params = Map.merge(params, %{immediate_destination_name: content})
      file_header = FileHeader.add_fields(new_file_header, updated_params)

      assert file_header.immediate_destination_name.name == :immediate_destination_name
      assert file_header.immediate_destination_name.content == content
      assert file_header.immediate_destination_name.length == 23
      assert file_header.immediate_destination_name.position == 41
      assert file_header.immediate_destination_name.required == false
    end

    test "add immediate_origin_name", %{file_header: new_file_header, params: params} do
      content = "CIVILCODE"
      updated_params = Map.merge(params, %{immediate_origin_name: content})
      file_header = FileHeader.add_fields(new_file_header, updated_params)

      assert file_header.immediate_origin_name.name == :immediate_origin_name
      assert file_header.immediate_origin_name.content == content
      assert file_header.immediate_origin_name.length == 23
      assert file_header.immediate_origin_name.position == 64
      assert file_header.immediate_origin_name.required == false
    end

    test "add reference_code", %{file_header: new_file_header, params: params} do
      content = "REFCODE"
      updated_params = Map.merge(params, %{reference_code: content})
      file_header = FileHeader.add_fields(new_file_header, updated_params)

      assert file_header.reference_code.name == :reference_code
      assert file_header.reference_code.content == "REFCODE"
      assert file_header.reference_code.length == 8
      assert file_header.reference_code.position == 87
      assert file_header.reference_code.required == true
    end
  end
end
