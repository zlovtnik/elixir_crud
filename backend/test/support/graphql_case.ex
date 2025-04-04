defmodule ErpWeb.GraphQLCase do
  @moduledoc """
  This module defines the test case to be used by
  GraphQL tests.
  """

  use ExUnit.CaseTemplate
  require Phoenix.ConnTest

  @endpoint ErpWeb.Endpoint

  using do
    quote do
      import ErpWeb.GraphQLCase
    end
  end

  def query_test_string(query, variables) do
    Jason.encode!(%{
      "query" => query,
      "variables" => variables
    })
  end

  def mutation_test_string(mutation, variables) do
    Jason.encode!(%{
      "query" => mutation,
      "variables" => variables
    })
  end

  def graphql_query(conn, query, variables \\ %{}) do
    conn
    |> Plug.Conn.put_req_header("content-type", "application/json")
    |> Phoenix.ConnTest.post("/api", query_test_string(query, variables))
  end

  def graphql_mutation(conn, mutation, variables \\ %{}) do
    conn
    |> Plug.Conn.put_req_header("content-type", "application/json")
    |> Phoenix.ConnTest.post("/api", mutation_test_string(mutation, variables))
  end
end
