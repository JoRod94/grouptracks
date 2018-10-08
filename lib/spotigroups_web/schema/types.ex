defmodule SpotigroupsWeb.Schema.Types do
  use Absinthe.Schema.Notation
  use Absinthe.Ecto, repo: Spotigroups.Repo

  object :user do
    field :id, non_null(:id)
    field :spotify_id, non_null(:string)
  end

  object :group do 
    field :id, non_null(:id)
    field :name, :string
    field :playlists, list_of(:playlist), resolve: assoc(:playlists)
  end

  object :playlist do
    field :id, non_null(:id)
    field :songs, list_of(:string)
    field :spotify_id, :string
    field :group_id, :group, resolve: assoc(:group)
  end
end