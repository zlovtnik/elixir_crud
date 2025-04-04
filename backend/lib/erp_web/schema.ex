defmodule ErpWeb.Schema do
  use Absinthe.Schema
  import_types(ErpWeb.Schema.ScalarTypes)
  import_types(ErpWeb.Schema.OrganizationTypes)
  import_types(ErpWeb.Schema.CustomerTypes)

  alias ErpWeb.Resolvers

  def context(ctx) do
    loader =
      Dataloader.new()
      |> Dataloader.add_source(Erp.Organizations, Erp.Organizations.data())
      |> Dataloader.add_source(Erp.Customers, Erp.Customers.data())

    Map.put(ctx, :loader, loader)
  end

  def plugins do
    [Absinthe.Middleware.Dataloader] ++ Absinthe.Plugin.defaults()
  end

  query do
    field :organization, :organization do
      arg(:id, non_null(:id))
      resolve(&Resolvers.Organizations.find_organization/3)
    end

    field :organizations, list_of(:organization) do
      resolve(&Resolvers.Organizations.list_organizations/3)
    end

    field :organization_unit, :organization_unit do
      arg(:id, non_null(:id))
      resolve(&Resolvers.Organizations.find_organization_unit/3)
    end

    field :organization_units, list_of(:organization_unit) do
      arg(:organization_id, :id)
      resolve(&Resolvers.Organizations.list_organization_units/3)
    end

    field :customer, :customer do
      arg(:id, non_null(:id))
      resolve(&Resolvers.Customers.find_customer/3)
    end

    field :customers, list_of(:customer) do
      resolve(&Resolvers.Customers.list_customers/3)
    end
  end

  mutation do
    field :create_organization, :organization do
      arg(:name, non_null(:string))
      arg(:code, non_null(:string))
      arg(:description, :string)
      arg(:active, :boolean)

      resolve(&Resolvers.Organizations.create_organization/3)
    end

    field :update_organization, :organization do
      arg(:id, non_null(:id))
      arg(:name, :string)
      arg(:code, :string)
      arg(:description, :string)
      arg(:active, :boolean)

      resolve(&Resolvers.Organizations.update_organization/3)
    end

    field :create_organization_unit, :organization_unit do
      arg(:name, non_null(:string))
      arg(:code, non_null(:string))
      arg(:description, :string)
      arg(:active, :boolean)
      arg(:organization_id, non_null(:id))

      resolve(&Resolvers.Organizations.create_organization_unit/3)
    end

    field :update_organization_unit, :organization_unit do
      arg(:id, non_null(:id))
      arg(:name, :string)
      arg(:code, :string)
      arg(:description, :string)
      arg(:active, :boolean)
      arg(:organization_id, :id)

      resolve(&Resolvers.Organizations.update_organization_unit/3)
    end

    field :create_customer, :customer do
      arg(:input, non_null(:customer_input))
      resolve(&Resolvers.Customers.create_customer/3)
    end

    field :update_customer, :customer do
      arg(:id, non_null(:id))
      arg(:input, non_null(:customer_input))
      resolve(&Resolvers.Customers.update_customer/3)
    end

    field :delete_customer, :boolean do
      arg(:id, non_null(:id))
      resolve(&Resolvers.Customers.delete_customer/3)
    end
  end
end
