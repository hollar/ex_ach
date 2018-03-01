defmodule ExAch.FileHeaderTest do
  use ExUnit.Case

  alias ExAch.FileHeader

  describe "adding file header fields" do
    setup do
      params = %{
        immediate_destination: %{content: "b071000505"},
        immediate_origin: %{content: "012345679"},
        file_creation_date: %{content: "180415"},
        file_creation_time: %{content: "1205"},
        file_id_modifier: %{content: "1"},
        immediate_destination_name: %{content: "RBC ROYAL Bank"},
        immediate_origin_name: %{content: "ORIGIN Bank"},
        reference_code: %{content: "refcode"}
      }

      [file_header: FileHeader.new(), params: params]
    end

    test "add record_type_code", %{file_header: new_file_header, params: params} do
      file_header = FileHeader.add_fields(new_file_header, params)

      assert file_header.record_type_code.name == "Record Type Code"
      assert file_header.record_type_code.content == "1"
      assert file_header.record_type_code.length == 1
      assert file_header.record_type_code.position == {1, 1}
      assert file_header.record_type_code.is_mandatory == true
    end

    test "add priority_code", %{file_header: new_file_header, params: params} do
      file_header = FileHeader.add_fields(new_file_header, params)

      assert file_header.priority_code.name == "Priority Code"
      assert file_header.priority_code.content == "01"
      assert file_header.priority_code.length == 2
      assert file_header.priority_code.position == {2, 3}
      assert file_header.priority_code.is_mandatory == true
    end

    test "add immediate_destination", %{file_header: new_file_header, params: params} do
      content = "b071000505"
      updated_params = Map.merge(params, %{immediate_destination: %{content: content}})
      file_header = FileHeader.add_fields(new_file_header, updated_params)

      assert file_header.immediate_destination.name == "Immediate Destination"
      assert file_header.immediate_destination.content == content
      assert file_header.immediate_destination.length == 10
      assert file_header.immediate_destination.position == {4, 13}
      assert file_header.immediate_destination.is_mandatory == true
    end

    test "add immediate_origin", %{file_header: new_file_header, params: params} do
      content = "012345679"
      updated_params = Map.merge(params, %{immediate_origin: %{content: content}})
      file_header = FileHeader.add_fields(new_file_header, updated_params)

      assert file_header.immediate_origin.name == "Immediate Origin"
      assert file_header.immediate_origin.content == content
      assert file_header.immediate_origin.length == 10
      assert file_header.immediate_origin.position == {14, 23}
      assert file_header.immediate_origin.is_mandatory == true
    end

    test "add file_creation_date", %{file_header: new_file_header, params: params} do
      content = "180325"
      updated_params = Map.merge(params, %{file_creation_date: %{content: content}})
      file_header = FileHeader.add_fields(new_file_header, updated_params)

      assert file_header.file_creation_date.name == "File Creation Date"
      assert file_header.file_creation_date.content == content
      assert file_header.file_creation_date.length == 6
      assert file_header.file_creation_date.position == {24, 29}
      assert file_header.file_creation_date.is_mandatory == true
    end

    test "add file_creation_time", %{file_header: new_file_header, params: params} do
      content = "1103"
      updated_params = Map.merge(params, %{file_creation_time: %{content: content}})
      file_header = FileHeader.add_fields(new_file_header, updated_params)

      assert file_header.file_creation_time.name == "File Creation Time"
      assert file_header.file_creation_time.content == content
      assert file_header.file_creation_time.length == 4
      assert file_header.file_creation_time.position == {30, 33}
      assert file_header.file_creation_time.is_mandatory == false
    end

    test "add file_id_modifier", %{file_header: new_file_header, params: params} do
      content = "3"
      updated_params = Map.merge(params, %{file_id_modifier: %{content: content}})
      file_header = FileHeader.add_fields(new_file_header, updated_params)

      assert file_header.file_id_modifier.name == "File ID modifier"
      assert file_header.file_id_modifier.content == content
      assert file_header.file_id_modifier.length == 1
      assert file_header.file_id_modifier.position == {34, 34}
      assert file_header.file_id_modifier.is_mandatory == true
    end

    test "add record_size", %{file_header: new_file_header, params: params} do
      file_header = FileHeader.add_fields(new_file_header, params)

      assert file_header.record_size.name == "Record Size"
      assert file_header.record_size.content == "094"
      assert file_header.record_size.length == 3
      assert file_header.record_size.position == {35, 37}
      assert file_header.record_size.is_mandatory == true
    end

    test "add blocking_factor", %{file_header: new_file_header, params: params} do
      file_header = FileHeader.add_fields(new_file_header, params)

      assert file_header.blocking_factor.name == "Blocking Factor"
      assert file_header.blocking_factor.content == "10"
      assert file_header.blocking_factor.length == 2
      assert file_header.blocking_factor.position == {38, 39}
      assert file_header.blocking_factor.is_mandatory == true
    end

    test "add format_code", %{file_header: new_file_header, params: params} do
      file_header = FileHeader.add_fields(new_file_header, params)

      assert file_header.format_code.name == "Format Code"
      assert file_header.format_code.content == "1"
      assert file_header.format_code.length == 1
      assert file_header.format_code.position == {40, 40}
      assert file_header.format_code.is_mandatory == true
    end

    test "add immediate_destination_name", %{file_header: new_file_header, params: params} do
      content = "LaSalle Bank N.A"
      updated_params = Map.merge(params, %{immediate_destination_name: %{content: content}})
      file_header = FileHeader.add_fields(new_file_header, updated_params)

      assert file_header.immediate_destination_name.name == "Immediate Destination Name"
      assert file_header.immediate_destination_name.content == content
      assert file_header.immediate_destination_name.length == 23
      assert file_header.immediate_destination_name.position == {41, 63}
      assert file_header.immediate_destination_name.is_mandatory == false
    end

    test "add immediate_origin_name", %{file_header: new_file_header, params: params} do
      content = "CIVILCODE"
      updated_params = Map.merge(params, %{immediate_origin_name: %{content: content}})
      file_header = FileHeader.add_fields(new_file_header, updated_params)

      assert file_header.immediate_origin_name.name == "Immediate Origin Name"
      assert file_header.immediate_origin_name.content == content
      assert file_header.immediate_origin_name.length == 23
      assert file_header.immediate_origin_name.position == {64, 86}
      assert file_header.immediate_origin_name.is_mandatory == false
    end

    test "add reference_code", %{file_header: new_file_header, params: params} do
      content = "REFCODE"
      updated_params = Map.merge(params, %{reference_code: %{content: content}})
      file_header = FileHeader.add_fields(new_file_header, updated_params)

      assert file_header.reference_code.name == "Reference Code"
      assert file_header.reference_code.content == "REFCODE"
      assert file_header.reference_code.length == 8
      assert file_header.reference_code.position == {87, 94}
      assert file_header.reference_code.is_mandatory == true
    end
  end
end
