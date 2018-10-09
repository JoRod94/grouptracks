defmodule SpotigroupsWeb.Schema.Types do
  use Absinthe.Schema.Notation
  use Absinthe.Ecto, repo: Spotigroups.Repo

  object :user do
    field :id, non_null(:id)
    field :spotify_id, non_null(:string)
    field :groups, list_of(:group), resolve: assoc(:group)
  end

  object :group do 
    field :id, non_null(:id)
    field :name, :string
    field :playlists, list_of(:playlist), resolve: assoc(:playlists)
    field :users, list_of(:user), resolve: assoc(:users)
  end

  object :playlist do
    field :id, non_null(:id)
    field :songs, list_of(:string)
    field :spotify_id, :string
    field :group_id, :group, resolve: assoc(:group)
  end
end