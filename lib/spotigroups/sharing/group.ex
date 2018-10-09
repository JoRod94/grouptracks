defmodule Spotigroups.Sharing.Group do
  use Ecto.Schema
  import Ecto.Changeset


  schema "groups" do
    field :name, :string
    has_many :playlists, Spotigroups.Music.Playlist
    many_to_many :users, Spotigroups.Accounts.User, join_through: Spotigroups.Sharing.GroupUser

    timestamps()
  end

  @doc false
  def changeset(group, attrs) do
    group
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
