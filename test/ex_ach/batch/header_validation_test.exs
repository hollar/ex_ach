defmodule ExAch.Batch.HeaderValidationTest do
  use ExAch.TestCase

  alias ExAch.Batch.Header.Fields.{
    ServiceClassCode,
    CompanyName,
    CompanyIdentification
  }

  describe "validating service_class_code" do
    test "a valid value returns successfully" do
      assert {:ok, %ServiceClassCode{content: 220}} = ServiceClassCode.new(220)
    end

    test "an invalid value returns an error" do
      assert {:error, [{:service_class_code, :non_permitted, "Must be 220, 200 or 225"}]} =
         ServiceClassCode.new(345)
    end
  end

  describe "validating company_name" do
    test "an invalid value returns an error" do
      assert {:error, [{:company_name, :max_length, "Must be less than 16 character"}]} =
         CompanyName.new("company name too long")
    end

    test "an non alphanum character returns an error" do
      assert {:error, [{:company_name, :format, "Must be alphanum"}]} =
         CompanyName.new("company_name")
    end

    test "two errors get accumulated" do
      {:error, errors} = CompanyName.new("company_name too long")

      assert {:company_name, :format, "Must be alphanum"} in errors
      assert {:company_name, :max_length, "Must be less than 16 character"} in errors
    end

    test "valid value returns successfully" do
      {:ok, %CompanyName{content: "CompanyName"}} = CompanyName.new("CompanyName")
    end
  end

  describe "validating company_identification" do
    test "an invalid value returns an error" do
      assert {:error, [{:company_identification, :length, "Must be 10 digits" }]} =
        CompanyIdentification.new(12345678900)
    end

    test "valid value returns successfully" do
      {:ok, %CompanyIdentification{content: 1112223334}} =
        CompanyIdentification.new(1112223334)
    end
  end
end
