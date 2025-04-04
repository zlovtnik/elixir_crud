defmodule ErpWeb.Schema.OrganizationTest do
  use ErpWeb.ConnCase
  require Phoenix.ConnTest

  @create_org_mutation """
  mutation CreateOrganization($name: String!, $code: String!, $description: String) {
    createOrganization(name: $name, code: $code, description: $description) {
      id
      name
      code
      description
    }
  }
  """

  @update_org_mutation """
  mutation UpdateOrganization($id: ID!, $name: String, $description: String) {
    updateOrganization(id: $id, name: $name, description: $description) {
      id
      name
      description
    }
  }
  """

  @get_org_query """
  query GetOrganization($id: ID!) {
    organization(id: $id) {
      id
      name
      code
      description
    }
  }
  """

  @list_orgs_query """
  query ListOrganizations {
    organizations {
      id
      name
      code
      description
    }
  }
  """

  describe "organization mutations" do
    test "create organization", %{conn: conn} do
      variables = %{
        "name" => "Test Organization",
        "code" => "TEST_ORG",
        "description" => "A test organization"
      }

      conn = graphql_mutation(conn, @create_org_mutation, variables)
      assert json_response(conn, 200)

      response = json_response(conn, 200)
      assert response["data"]["createOrganization"]["name"] == "Test Organization"
      assert response["data"]["createOrganization"]["code"] == "TEST_ORG"
      assert response["data"]["createOrganization"]["description"] == "A test organization"
    end

    test "update organization", %{conn: conn} do
      # First create an organization
      create_variables = %{
        "name" => "Test Organization",
        "code" => "TEST_ORG",
        "description" => "A test organization"
      }

      conn =
        graphql_mutation(Phoenix.ConnTest.build_conn(), @create_org_mutation, create_variables)

      org = json_response(conn, 200)["data"]["createOrganization"]

      # Then update it
      variables = %{
        "id" => org["id"],
        "name" => "Updated Organization",
        "description" => "An updated organization"
      }

      conn = graphql_mutation(Phoenix.ConnTest.build_conn(), @update_org_mutation, variables)
      assert json_response(conn, 200)

      response = json_response(conn, 200)
      assert response["data"]["updateOrganization"]["name"] == "Updated Organization"
      assert response["data"]["updateOrganization"]["description"] == "An updated organization"
    end
  end

  describe "organization queries" do
    test "get organization", %{conn: conn} do
      # First create an organization
      create_variables = %{
        "name" => "Test Organization",
        "code" => "TEST_ORG",
        "description" => "A test organization"
      }

      conn =
        graphql_mutation(Phoenix.ConnTest.build_conn(), @create_org_mutation, create_variables)

      org = json_response(conn, 200)["data"]["createOrganization"]

      # Then get it
      variables = %{"id" => org["id"]}

      conn = graphql_query(Phoenix.ConnTest.build_conn(), @get_org_query, variables)
      assert json_response(conn, 200)

      response = json_response(conn, 200)
      assert response["data"]["organization"]["id"] == org["id"]
      assert response["data"]["organization"]["name"] == "Test Organization"
    end

    test "list organizations", %{conn: conn} do
      # First create two organizations
      create_variables1 = %{
        "name" => "Test Organization 1",
        "code" => "TEST_ORG_1",
        "description" => "A test organization"
      }

      create_variables2 = %{
        "name" => "Test Organization 2",
        "code" => "TEST_ORG_2",
        "description" => "Another test organization"
      }

      conn =
        graphql_mutation(Phoenix.ConnTest.build_conn(), @create_org_mutation, create_variables1)

      conn =
        graphql_mutation(Phoenix.ConnTest.build_conn(), @create_org_mutation, create_variables2)

      # Then list them
      conn = graphql_query(Phoenix.ConnTest.build_conn(), @list_orgs_query)
      assert json_response(conn, 200)

      response = json_response(conn, 200)
      assert length(response["data"]["organizations"]) == 2
    end
  end
end
