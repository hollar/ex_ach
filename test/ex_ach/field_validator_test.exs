defmodule ExAch.FieldValidatorTest do
  use ExUnit.Case
  alias ExAch.FieldValidator

  describe "validating string type" do
    test "a non-string type returns an error" do
      specifications = [{:field_name, :type, :string}]
      errors = FieldValidator.validate(123, specifications)

      assert errors == [{:field_name, :type, "Must be an alphanum string"}]
    end

    test "a type of string does not returns error" do
      specifications = [{:field_name, :type, :string}]
      errors = FieldValidator.validate("string", specifications)

      assert Enum.empty?(errors)
    end
  end

  describe "validating atom type" do
    test "a non-atom type returns an error" do
      specifications = [{:field_name, :type, :atom}]
      errors = FieldValidator.validate(123, specifications)

      assert errors == [{:field_name, :type, "Must be an atom"}]
    end

    test "a type of atom returns does not return error" do
      specifications = [{:field_name, :type, :atom}]
      errors = FieldValidator.validate(:atom, specifications)

      assert Enum.empty?(errors)
    end
  end

  describe "validating integer type" do
    test "type of string returns an error" do
      specifications = [{:field_name, :type, :integer}]
      errors = FieldValidator.validate("123", specifications)

      assert errors == [{:field_name, :type, "Must be an integer"}]
    end

    test "type of integer does not return errors" do
      specifications = [{:field_name, :type, :integer}]
      errors = FieldValidator.validate(123, specifications)

      assert Enum.empty?(errors)
    end
  end

  describe "validating date type" do
    test "type of date returns an error" do
      specifications = [{:field_name, :type, :date}]
      errors = FieldValidator.validate("123", specifications)

      assert errors == [{:field_name, :type, "Must be a date"}]
    end

    test "type of date does not return errors" do
      specifications = [{:field_name, :type, :date}]
      errors = FieldValidator.validate(~D[2001-01-01], specifications)

      assert Enum.empty?(errors)
    end
  end

  describe "validating max_length" do
    test "a string too long returns an error" do
      specifications = [{:field_name, :max_length, 3}]
      errors = FieldValidator.validate("1234", specifications)

      assert errors == [{:field_name, :max_length, "Must be less than 3 character(s)"}]
    end

    test "a integer too long returns an error" do
      specifications = [{:field_name, :max_length, 3}]
      errors = FieldValidator.validate(1234, specifications)

      assert errors == [{:field_name, :max_length, "Must be less than 3 digit(s)"}]
    end

    test "valid string does not return errors" do
      specifications = [{:field_name, :max_length, 1}]
      errors = FieldValidator.validate("a", specifications)

      assert Enum.empty?(errors)
    end

    test "valid integer does not return errors" do
      specifications = [{:field_name, :max_length, 1}]
      errors = FieldValidator.validate(1, specifications)

      assert Enum.empty?(errors)
    end
  end

  describe "validating length" do
    test "a string too long returns an error" do
      specifications = [{:field_name, :length, 3}]
      errors = FieldValidator.validate("1234", specifications)

      assert errors == [{:field_name, :length, "Must be 3 character(s)"}]
    end

    test "a integer too long returns an error" do
      specifications = [{:field_name, :length, 3}]
      errors = FieldValidator.validate(1234, specifications)

      assert errors == [{:field_name, :length, "Must be 3 digit(s)"}]
    end

    test "valid string does not return errors" do
      specifications = [{:field_name, :length, 1}]
      errors = FieldValidator.validate("a", specifications)

      assert Enum.empty?(errors)
    end

    test "valid integer does not return errors" do
      specifications = [{:field_name, :length, 1}]
      errors = FieldValidator.validate(1, specifications)

      assert Enum.empty?(errors)
    end
  end

  describe "validating inclusion" do
    test "not allowed values returns an error" do
      specifications = [{:field_name, :inclusion, [1, 2]}]
      errors = FieldValidator.validate(3, specifications)

      assert errors == [{:field_name, :inclusion, "Must be in [1,2]"}]
    end

    test "allowed value does not return errors" do
      specifications = [{:field_name, :inclusion, [1, 2]}]
      errors = FieldValidator.validate(1, specifications)

      assert Enum.empty?(errors)
    end
  end
end
