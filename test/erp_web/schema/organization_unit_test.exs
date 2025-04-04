defmodule ErpWeb.Schema.OrganizationUnitTest do
  use ErpWeb.ConnCase
  require Phoenix.ConnTest

  @create_unit_mutation """
  mutation CreateOrganizationUnit($name: String!, $code: String!, $description: String, $organizationId: ID!) {
    createOrganizationUnit(name: $name, code: $code, description: $description, organizationId: $organizationId) {
      id
      name
      code
      description
      organization {
        id
      }
    }
  }
  """

  @update_unit_mutation """
  mutation UpdateOrganizationUnit($id: ID!, $name: String, $description: String) {
    updateOrganizationUnit(id: $id, name: $name, description: $description) {
      id
      name
      description
    }
  }
  """

  @get_unit_query """
  query GetOrganizationUnit($id: ID!) {
    organizationUnit(id: $id) {
      id
      name
      code
      description
      organization {
        id
      }
    }
  }
  """

  @list_units_query """
  query ListOrganizationUnits($organizationId: ID!) {
    organizationUnits(organizationId: $organizationId) {
      id
      name
      code
      description
      organization {
        id
      }
    }
  }
  """

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

  describe "organization unit mutations" do
    test "create organization unit", %{conn: conn} do
      # First create an organization
      org_variables = %{
        "name" => "Test Organization",
        "code" => "TEST_ORG",
        "description" => "A test organization"
      }

      conn = graphql_mutation(Phoenix.ConnTest.build_conn(), @create_org_mutation, org_variables)
      org = json_response(conn, 200)["data"]["createOrganization"]

      # Then create an organization unit
      variables = %{
        "name" => "Test Unit",
        "code" => "TEST_UNIT",
        "description" => "A test unit",
        "organizationId" => org["id"]
      }

      conn = graphql_mutation(Phoenix.ConnTest.build_conn(), @create_unit_mutation, variables)
      assert json_response(conn, 200)

      response = json_response(conn, 200)
      assert response["data"]["createOrganizationUnit"]["name"] == "Test Unit"
      assert response["data"]["createOrganizationUnit"]["code"] == "TEST_UNIT"
      assert response["data"]["createOrganizationUnit"]["description"] == "A test unit"
      assert response["data"]["createOrganizationUnit"]["organization"]["id"] == org["id"]
    end

    test "update organization unit", %{conn: conn} do
      # First create an organization
      org_variables = %{
        "name" => "Test Organization",
        "code" => "TEST_ORG",
        "description" => "A test organization"
      }

      conn = graphql_mutation(Phoenix.ConnTest.build_conn(), @create_org_mutation, org_variables)
      org = json_response(conn, 200)["data"]["createOrganization"]

      # Then create an organization unit
      create_variables = %{
        "name" => "Test Unit",
        "code" => "TEST_UNIT",
        "description" => "A test unit",
        "organizationId" => org["id"]
      }

      conn =
        graphql_mutation(Phoenix.ConnTest.build_conn(), @create_unit_mutation, create_variables)

      unit = json_response(conn, 200)["data"]["createOrganizationUnit"]

      # Then update it
      variables = %{
        "id" => unit["id"],
        "name" => "Updated Unit",
        "description" => "An updated unit"
      }

      conn = graphql_mutation(Phoenix.ConnTest.build_conn(), @update_unit_mutation, variables)
      assert json_response(conn, 200)

      response = json_response(conn, 200)
      assert response["data"]["updateOrganizationUnit"]["name"] == "Updated Unit"
      assert response["data"]["updateOrganizationUnit"]["description"] == "An updated unit"
    end
  end

  describe "organization unit queries" do
    test "get organization unit", %{conn: conn} do
      # First create an organization
      org_variables = %{
        "name" => "Test Organization",
        "code" => "TEST_ORG",
        "description" => "A test organization"
      }

      conn = graphql_mutation(Phoenix.ConnTest.build_conn(), @create_org_mutation, org_variables)
      org = json_response(conn, 200)["data"]["createOrganization"]

      # Then create an organization unit
      create_variables = %{
        "name" => "Test Unit",
        "code" => "TEST_UNIT",
        "description" => "A test unit",
        "organizationId" => org["id"]
      }

      conn =
        graphql_mutation(Phoenix.ConnTest.build_conn(), @create_unit_mutation, create_variables)

      unit = json_response(conn, 200)["data"]["createOrganizationUnit"]

      # Then get it
      variables = %{"id" => unit["id"]}

      conn = graphql_query(Phoenix.ConnTest.build_conn(), @get_unit_query, variables)
      assert json_response(conn, 200)

      response = json_response(conn, 200)
      assert response["data"]["organizationUnit"]["id"] == unit["id"]
      assert response["data"]["organizationUnit"]["name"] == "Test Unit"
    end

    test "list organization units", %{conn: conn} do
      # First create an organization
      org_variables = %{
        "name" => "Test Organization",
        "code" => "TEST_ORG",
        "description" => "A test organization"
      }

      conn = graphql_mutation(Phoenix.ConnTest.build_conn(), @create_org_mutation, org_variables)
      org = json_response(conn, 200)["data"]["createOrganization"]

      # Then create two organization units
      create_variables1 = %{
        "name" => "Test Unit 1",
        "code" => "TEST_UNIT_1",
        "description" => "A test unit",
        "organizationId" => org["id"]
      }

      create_variables2 = %{
        "name" => "Test Unit 2",
        "code" => "TEST_UNIT_2",
        "description" => "Another test unit",
        "organizationId" => org["id"]
      }

      conn =
        graphql_mutation(Phoenix.ConnTest.build_conn(), @create_unit_mutation, create_variables1)

      conn =
        graphql_mutation(Phoenix.ConnTest.build_conn(), @create_unit_mutation, create_variables2)

      # Then list them
      variables = %{"organizationId" => org["id"]}

      conn = graphql_query(Phoenix.ConnTest.build_conn(), @list_units_query, variables)
      assert json_response(conn, 200)

      response = json_response(conn, 200)
      assert length(response["data"]["organizationUnits"]) == 2
    end
  end
end
