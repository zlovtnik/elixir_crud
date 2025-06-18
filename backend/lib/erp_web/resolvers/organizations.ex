defmodule ErpWeb.Resolvers.Organizations do
  @moduledoc """
  Provides resolver functions for organization and organization unit GraphQL queries and mutations.
  """
  alias Erp.Organizations

  def find_organization(_parent, %{id: id}, _resolution) do
    case Organizations.get_organization(id) do
      nil -> {:error, "Organization not found"}
      organization -> {:ok, organization}
    end
  end

  def list_organizations(_parent, _args, _resolution) do
    {:ok, Organizations.list_organizations()}
  end

  def create_organization(_parent, args, _resolution) do
    Organizations.create_organization(args)
  end

  def update_organization(_parent, %{id: id} = args, _resolution) do
    organization = Organizations.get_organization(id)
    Organizations.update_organization(organization, args)
  end

  def find_organization_unit(_parent, %{id: id}, _resolution) do
    case Organizations.get_organization_unit(id) do
      nil -> {:error, "Organization unit not found"}
      unit -> {:ok, unit}
    end
  end

  def list_organization_units(_parent, args, _resolution) do
    {:ok, Organizations.list_organization_units(args)}
  end

  def create_organization_unit(_parent, args, _resolution) do
    Organizations.create_organization_unit(args)
  end

  def update_organization_unit(_parent, %{id: id} = args, _resolution) do
    unit = Organizations.get_organization_unit(id)
    Organizations.update_organization_unit(unit, args)
  end
end
