defmodule Erp.Organizations.Organization do
  use Ecto.Schema
  import Ecto.Changeset

  schema "organizations" do
    field :name, :string
    field :code, :string
    field :description, :string
    field :active, :boolean, default: true

    has_many :organization_units, Erp.Organizations.OrganizationUnit

    timestamps()
  end

  def changeset(organization, attrs) do
    organization
    |> cast(attrs, [:name, :code, :description, :active])
    |> validate_required([:name, :code])
    |> unique_constraint(:code)
  end
end
