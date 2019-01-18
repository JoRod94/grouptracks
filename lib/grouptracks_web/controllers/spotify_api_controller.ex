defmodule GrouptracksWeb.SpotifyApiController do
  use GrouptracksWeb, :controller
  alias Grouptracks.Services.SpotifyApi

  def auth(conn, params) do
    auth_url = "https://accounts.spotify.com/authorize?client_id=#{SpotifyApi.get_client_id()}&response_type=code&redirect_uri=http%3A%2F%2Flocalhost:4000%2Fspotify%2Fcallback&scope=user-top-read&state=34fFs29kd09"
    conn |> redirect(external: auth_url)
  end

  def callback(conn, params) do
    if Map.has_key?(params, "error") do
      IO.inspect params["error"]
    else
      access_token = SpotifyApi.request_access_token(params["code"])
      IO.inspect access_token
    end
    conn
      |> put_status(:ok)
      |> json(%{})
  end
end
