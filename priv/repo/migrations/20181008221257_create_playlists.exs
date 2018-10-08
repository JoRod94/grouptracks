defmodule Spotigroups.Repo.Migrations.CreatePlaylists do
  use Ecto.Migration

  def change do
    create table(:playlists) do
      add :spotify_id, :string
      add :songs, {:array, :string}

      timestamps()
    end

    create unique_index(:playlists, [:spotify_id])
  end
end
