defmodule Spotigroups.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :spotify_id, :string

      timestamps()
    end

  end
end
