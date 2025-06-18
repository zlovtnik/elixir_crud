defmodule ErpWeb.Schema.ScalarTypes do
  @moduledoc """
  Custom scalar types for Absinthe GraphQL schema.
  """
  use Absinthe.Schema.Notation

  scalar :naive_datetime, description: "ISOz naive datetime" do
    serialize(&NaiveDateTime.to_iso8601/1)
    parse(&parse_naive_datetime/1)
  end

  defp parse_naive_datetime(%Absinthe.Blueprint.Input.String{value: value}) do
    case NaiveDateTime.from_iso8601(value) do
      {:ok, datetime, _} -> {:ok, datetime}
      _ -> :error
    end
  end

  defp parse_naive_datetime(_), do: :error
end
