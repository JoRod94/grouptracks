defmodule SpotigroupsWeb.Schema do
  use Absinthe.Schema
  import_types SpotigroupsWeb.Schema.Types
  alias SpotigroupsWeb.AccountsResolver
  alias SpotigroupsWeb.SharingResolver
  alias SpotigroupsWeb.MusicResolver

  query do
    field :all_users, non_null(list_of(non_null(:user))) do
      resolve &AccountsResolver.all_users/3
    end

    field :all_groups, non_null(list_of(non_null(:group))) do
      resolve &SharingResolver.all_groups/3
    end

    field :all_playlists, non_null(list_of(non_null(:playlist))) do
      resolve &MusicResolver.all_playlists/3
    end
  end

  mutation do
    field :create_user, :user do
      arg :social_id, non_null(:string)

      resolve &AccountsResolver.create_user/3
    end

    field :create_group, :group do
      arg :name, non_null(:string)
      arg :users, non_null(list_of(:string))

      resolve &SharingResolver.create_group/3
    end

    field :generate_playlist, :playlist do
      arg :group_id, non_null(:integer)

      resolve &MusicResolver.generate_playlist/3
    end
  end
end