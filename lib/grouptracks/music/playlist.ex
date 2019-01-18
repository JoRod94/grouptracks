defmodule Grouptracks.Music.Playlist do
  use Ecto.Schema
  import Ecto.Changeset


  schema "playlists" do
    field :songs, {:array, :string}
    field :spotify_id, :string
    belongs_to :group, Grouptracks.Sharing.Group

    timestamps()
  end

  @doc false
  def changeset(playlist, attrs) do
    playlist
    |> cast(attrs, [:spotify_id, :songs, :group_id])
    |> validate_required([:songs, :group_id])
    |> unique_constraint(:spotify_id)
  end
end
