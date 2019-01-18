defmodule GrouptracksWeb.MusicResolver do
  alias Grouptracks.Music
  alias Grouptracks.Services.Playlistinator

  def all_playlists(_root, _args, _info) do
    playlists = Music.list_playlists()
    {:ok, playlists}
  end

  def generate_playlist(_root, args, _info) do
  # TODO: add detailed error message handling later
    case Playlistinator.generate_playlist(args.group_id, args.nr_top_artists) do
      {:ok, playlist} ->
        {:ok, playlist}
      _error ->
        {:error, "could not generate playlist"}
    end
  end
end
