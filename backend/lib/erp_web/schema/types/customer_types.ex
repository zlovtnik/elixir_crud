defmodule ErpWeb.Schema.CustomerTypes do
  use Absinthe.Schema.Notation
  import Absinthe.Resolution.Helpers, only: [dataloader: 1]

  object :customer do
    field(:id, :id)
    field(:name, :string)
    field(:email, :string)
    field(:phone, :string)
    field(:address, :string)
    field(:inserted_at, :naive_datetime)
    field(:updated_at, :naive_datetime)
  end

  input_object :customer_input do
    field(:name, non_null(:string))
    field(:email, non_null(:string))
    field(:phone, non_null(:string))
    field(:address, non_null(:string))
  end
end
