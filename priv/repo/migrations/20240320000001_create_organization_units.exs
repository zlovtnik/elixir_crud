defmodule Erp.Repo.Migrations.CreateOrganizationUnits do
  use Ecto.Migration

  def change do
    create table(:organization_units) do
      add(:name, :string, null: false)
      add(:code, :string, null: false)
      add(:description, :text)
      add(:active, :boolean, default: true, null: false)
      add(:organization_id, references(:organizations, on_delete: :delete_all), null: false)

      timestamps()
    end

    create(unique_index(:organization_units, [:code]))
    create(index(:organization_units, [:organization_id]))
  end
end
