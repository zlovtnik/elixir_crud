defmodule Erp.Organizations.OrganizationUnit do
  @moduledoc """
  Schema and functions for organization units.
  """
  use Ecto.Schema
  import Ecto.Changeset

  schema "organization_units" do
    field :name, :string
    field :code, :string
    field :description, :string
    field :active, :boolean, default: true

    belongs_to :organization, Erp.Organizations.Organization

    timestamps()
  end

  def changeset(organization_unit, attrs) do
    organization_unit
    |> cast(attrs, [:name, :code, :description, :active, :organization_id])
    |> validate_required([:name, :code, :organization_id])
    |> unique_constraint(:code)
    |> assoc_constraint(:organization)
  end
end
