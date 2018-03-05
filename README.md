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

create new ach file struct:
```elixir
iex> ach = ExAch.new()
%ExAch.Ach{}
```

add file header:
```elixir
iex> file_header_params = %{
       immediate_destination: "b071000505",
       immediate_destination_name: "RBC ROYAL Bank",
       immediate_origin: "0123456789",
       immediate_origin_name: "ORIGIN Bank",
       file_creation_date: "180415",
       file_creation_time: "1205",
       file_id_modifier: "1",
       reference_code: "refcode"
     }
iex> ExAch.add_file_header(ach, file_header_params)
{:ok, %ExAch.Ach{file_header: %ExAch.FileHeader{blocking_factor: %ExAch.Field{...}, ...}}}
```

If requited parameter is missing or invalid the error is returned:

```elixir
iex> invalid_file_header_params = %{
       immediate_destination_name: "RBC ROYAL Bank",
       immediate_origin: "0123456789",
       immediate_origin_name: "ORIGIN Bank",
       file_creation_date: "180415",
       file_creation_time: "1205",
       file_id_modifier: "1",
       reference_code: "refcode"
     }
iex> ExAch.add_file_header(ach, invalid_file_header_params)
{:error, [{:error, :immediate_destination, :presence, "must be present"}]}
```

## Ach file specification

https://content.pncmc.com/live/pnc/corporate/treasury-management/ach-conversion/ACH-File-Specifications.pdf

## License
Released under the [MIT License](http://www.opensource.org/licenses/MIT).
