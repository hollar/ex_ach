# ExAch

**ACH (Automated Clearing House) file builder.**

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `ex_ach` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:ex_ach, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/ex_ach](https://hexdocs.pm/ex_ach).

## Usage
Create a file header:
```elixir
alias ExAch.File.Header

{:ok, immediate_destination} = File.Header.Fields.ImmediateDestination.new("b071000505")
{:ok, immediate_origin} = File.Header.Fields.ImmediateOrigin.new("b071000505")
{:ok, creation_date} = File.Header.Fields.CreateDate.new(~D[2018-01-25])
{:ok, reference_code} = File.Header.Fields.ReferenceCode.new("refcode")
{:ok, file_id_modifier} = File.Header.Fields.FileIdModifier.new("1")

{:ok, immediate_origin_name} = File.Header.Fields.ImmediateOriginName.new("RBC ROYAL Bank"),
{:ok, immediate_destination_name} = File.Header.Fields.ImmediateDestinationName.new("RBC ROYAL Bank"),
{:ok, file_creation_time} = File.Header.Fields.FileCreationTime.new(~T[23:00:07.000])

{:ok, file_header} =
  ExAch.File.Header.new(
    immediate_destination,
    immediate_origin,
    create_date,
    file_id_modifier,
    immediate_destination_name: immediate_destination_name,
    immediate_origin_name: immediate_origin_name,
    file_creation_time: file_creation_time,
    reference_code: reference_code
  )
```

Create a batch header
```elixir
alias ExAch.Batch.Header

{:ok, service_class_code} = Batch.Header.Fields.ServiceClassCode.new(220)
{:ok, company_name} = Batch.Header.Fields.CompanyName.new("CompanyName")
{:ok, company_identification} = Batch.Header.Fields.CompanyIdentifiation.new(1112223334)
{:ok, standard_entry_class_code} = Batch.Header.Fields.ServiceClassCode.new("WEB")
{:ok, company_entry_description} = Batch.Header.Fields.CompanyEntryDescription.new("DESC1")
{:ok, effective_entry_date} =  Batch.Header.Fields.EffectiveEntryDate.new(~D[2000-01-01])
{:ok, batch_number} = Batch.Header.Fields.BatchNumber.new(0123456)
{:ok, originating_dfi_identification} = Batch.Header.Fields.OriginatingDfiIdentification.new(12345678)

#Optional
{:ok, company_descriptive_date} = Batch.Header.Fields.CompanyDescriptiveDate.new(~D[2000-01-01])
{:ok, company_discretionary_data} = Batch.Header.Fields.CompanyDiscretionaryData.new("Data1")

{:ok, batch_header} =
  ExAch.Batch.Header.new(
    service_class_code
    company_name
    company_identification
    standard_entry_class_code
    company_entry_description
    effective_entry_date
    batch_number
    originating_dfi_identification,
    company_descriptive_date: company_descriptive_date,
    company_discretionary_data: company_discretionary_data
  )
```

Create a batch
```elixir
alias ExAch.Batch

{:ok, batch} = ExAch.Batch.new(header)
```

create new ach file struct:
```elixir
alias ExAch.{File, Batch}

{:ok, ach} = ExAch.File.new(file_header, batches)
%ExAch.File{file_header: %FileHeader{}, batches: [%Batch]}
```


ach = ExAch.new # => %ExAch.Ach{}

file_header_params = %{
  immediate_destination: "12345",
  ...
}
ExAch.add_header(ach, file_header_params)  #{:ok, ach} | {:error, [errors]}

## Ach file specification

https://content.pncmc.com/live/pnc/corporate/treasury-management/ach-conversion/ACH-File-Specifications.pdf

## License
Released under the [MIT License](http://www.opensource.org/licenses/MIT).
