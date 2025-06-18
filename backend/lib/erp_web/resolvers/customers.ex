defmodule ErpWeb.Resolvers.Customers do
  @moduledoc """
  Provides resolver functions for customer GraphQL queries and mutations.
  """
  alias Erp.Customers

  def find_customer(_parent, %{id: id}, _resolution) do
    case Customers.get_customer(id) do
      nil -> {:error, "Customer not found"}
      customer -> {:ok, customer}
    end
  end

  def list_customers(_parent, _args, _resolution) do
    {:ok, Customers.list_customers()}
  end

  def create_customer(_parent, args, _resolution) do
    Customers.create_customer(args)
  end

  def update_customer(_parent, %{id: id} = args, _resolution) do
    customer = Customers.get_customer(id)
    Customers.update_customer(customer, args)
  end

  def delete_customer(_parent, %{id: id}, _resolution) do
    customer = Customers.get_customer(id)
    Customers.delete_customer(customer)
  end
end
