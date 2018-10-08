defmodule Spotigroups.Repo.Migrations.PlaylistBelongsToGroup do
  use Ecto.Migration

  def change do
    alter table(:playlists) do
      add :group_id, references(:groups)
    end
  end
end
