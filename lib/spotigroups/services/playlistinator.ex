defmodule Spotigroups.Services.Playlistinator do
  alias Spotigroups.Sharing
  alias Spotigroups.Music

  def generate_playlist(group_id) do 
    group = Sharing.get_group!(group_id)
    # Playlistinator
    Music.create_playlist(%{group_id: group_id, songs: ["song1", "song2"]})
  end
end
