defmodule ErpWeb.Schema.OrganizationTypes do
  use Absinthe.Schema.Notation
  import Absinthe.Resolution.Helpers, only: [dataloader: 1]

  object :organization do
    field(:id, :id)
    field(:name, :string)
    field(:code, :string)
    field(:description, :string)
    field(:active, :boolean)

    field :organization_units, list_of(:organization_unit) do
      resolve(dataloader(Erp.Organizations))
    end

    field(:inserted_at, :naive_datetime)
    field(:updated_at, :naive_datetime)
  end

  object :organization_unit do
    field(:id, :id)
    field(:name, :string)
    field(:code, :string)
    field(:description, :string)
    field(:active, :boolean)

    field :organization, :organization do
      resolve(dataloader(Erp.Organizations))
    end

    field(:inserted_at, :naive_datetime)
    field(:updated_at, :naive_datetime)
  end
end
