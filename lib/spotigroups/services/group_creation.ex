defmodule Spotigroups.Services.GroupCreation do
  alias Spotigroups.Sharing
  alias Spotigroups.Accounts

  def get_users_by_spotify_ids(spotify_ids) do 
    Enum.map(spotify_ids, fn(s_id) -> 
      Accounts.get_user_by_spotify_id(s_id) 
    end)
  end
end
