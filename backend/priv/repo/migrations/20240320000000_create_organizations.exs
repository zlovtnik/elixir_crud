defmodule Erp.Repo.Migrations.CreateOrganizations do
  use Ecto.Migration

  def change do
    create table(:organizations) do
      add(:name, :string, null: false)
      add(:code, :string, null: false)
      add(:description, :text)
      add(:active, :boolean, default: true, null: false)

      timestamps()
    end

    create(unique_index(:organizations, [:code]))
  end
end
