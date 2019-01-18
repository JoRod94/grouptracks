defmodule Spotigroups.Services.GroupCreation do
  alias Spotigroups.Sharing
  alias Spotigroups.Accounts

  def get_users_by_social_ids(social_ids) do 
    Enum.map(social_ids, fn(s_id) -> 
      Accounts.get_user_by_social_id(s_id) 
    end)
  end
end
