defmodule Erp.Organizations do
  import Ecto.Query, warn: false
  alias Erp.Repo
  alias Erp.Organizations.Organization
  alias Erp.Organizations.OrganizationUnit

  def data do
    Dataloader.Ecto.new(Repo, query: &query/2)
  end

  def query(queryable, _) do
    queryable
  end

  def list_organizations do
    Repo.all(Organization)
  end

  def get_organization(id), do: Repo.get(Organization, id)

  def create_organization(attrs \\ %{}) do
    %Organization{}
    |> Organization.changeset(attrs)
    |> Repo.insert()
  end

  def update_organization(%Organization{} = organization, attrs) do
    organization
    |> Organization.changeset(attrs)
    |> Repo.update()
  end

  def list_organization_units(args \\ %{}) do
    OrganizationUnit
    |> maybe_filter_by_organization(args)
    |> Repo.all()
  end

  def get_organization_unit(id), do: Repo.get(OrganizationUnit, id)

  def create_organization_unit(attrs \\ %{}) do
    %OrganizationUnit{}
    |> OrganizationUnit.changeset(attrs)
    |> Repo.insert()
  end

  def update_organization_unit(%OrganizationUnit{} = unit, attrs) do
    unit
    |> OrganizationUnit.changeset(attrs)
    |> Repo.update()
  end

  defp maybe_filter_by_organization(query, %{organization_id: organization_id}) do
    from(q in query, where: q.organization_id == ^organization_id)
  end

  defp maybe_filter_by_organization(query, _), do: query
end
