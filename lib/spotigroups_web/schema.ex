defmodule SpotigroupsWeb.Schema do
  use Absinthe.Schema

  alias SpotigroupsWeb.AccountsResolver

  object :user do
    field :id, non_null(:id)
    field :spotify_id, non_null(:string)
  end

  query do
    field :all_users, non_null(list_of(non_null(:user))) do
      resolve &AccountsResolver.all_users/3
    end
  end

  mutation do
    field :create_user, :user do
      arg :spotify_id, non_null(:string)

      resolve &AccountsResolver.create_user/3
    end
  end
end