defmodule Grouptracks.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :social_id, :string

      timestamps()
    end

    create unique_index(:users, [:social_id])
  end
end
