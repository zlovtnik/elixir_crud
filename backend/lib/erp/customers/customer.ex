defmodule Erp.Customers.Customer do
  @moduledoc """
  Schema for customers.
  """
  use Ecto.Schema
  import Ecto.Changeset

  schema "customers" do
    field(:name, :string)
    field(:email, :string)
    field(:phone, :string)
    field(:address, :string)

    timestamps()
  end

  def changeset(customer, attrs) do
    customer
    |> cast(attrs, [:name, :email, :phone, :address])
    |> validate_required([:name, :email, :phone, :address])
    |> validate_format(:email, ~r/^[^\s]+@[^\s]+$/, message: "must have the @ sign and no spaces")
    |> unique_constraint(:email)
  end
end
