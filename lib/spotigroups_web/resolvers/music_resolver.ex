defmodule SpotigroupsWeb.MusicResolver do
  alias Spotigroups.Music

  def all_playlists(_root, _args, _info) do
    playlists = Music.list_playlists()
    {:ok, playlists}
  end

  def create_playlist(_root, args, _info) do
  # TODO: add detailed error message handling later
    case Music.create_playlist(args) do
      {:ok, playlist} ->
        {:ok, playlist}
      _error ->
        {:error, "could not create playlist"}
    end
  end
end