defmodule Grouptracks.Services.SpotifyApi do
  def get_client_id() do
    Application.get_env(:grouptracks, :spotify_client_id)
  end

  def request_access_token(code) do
    "potato"
  end

  def test_api_connection() do
  end
end
