defmodule GrouptracksWeb.SpotifyApiResolver do
  alias Grouptracks.Services.SpotifyApi

  def client_id(_root, _args, _info) do
    client_id = SpotifyApi.get_client_id()
    {:ok, client_id}
  end
end
