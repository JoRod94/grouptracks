defmodule Spotigroups.Music.Playlist do
  use Ecto.Schema
  import Ecto.Changeset


  schema "playlists" do
    field :songs, {:array, :string}
    field :spotify_id, :string
    belongs_to :group, Spotigroups.Sharing.Group

    timestamps()
  end

  @doc false
  def changeset(playlist, attrs) do
    playlist
    |> cast(attrs, [:spotify_id, :songs])
    |> validate_required([:spotify_id, :songs])
    |> unique_constraint(:spotify_id)
  end
end
