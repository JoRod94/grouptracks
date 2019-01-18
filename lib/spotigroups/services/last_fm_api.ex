defmodule Spotigroups.Services.LastFmApi do
  def api_get(url){
    case HTTPoison.get(url) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        result = Poison.decode!(body)
        if Map.has_key?("error", result), do
          {:error, "API Error: #{result["message"]}"}
        else
          {:ok, result}
      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, "Request Error: #{reason}"}
      _ ->
        {:error, "API Error"}
    end
  }

  def get_api_key() do
    Application.get_env(:spotigroups, :lastfm_api_key)
  end

  def get_user_top_artists(social_id) do
    nrArtists = 10
    api_get("http://ws.audioscrobbler.com/2.0/?method=user.gettopartists&limit=#{nrArtists}&user=#{social_id}&api_key=#{get_api_key()}&format=json")
  end

  def get_similar_artists(artist_social_id) do
    nrArtists = 10
    api_get("http://ws.audioscrobbler.com/2.0/?method=artist.getsimilar&limit=#{nrArtists}&mbid=#{"social_id"}&api_key=#{get_api_key()}&format=json")
  end

  def get_artist_top_tracks(artist_social_id) do
    nrTracks = 10
    api_get("http://ws.audioscrobbler.com/2.0/?method=artist.gettoptracks&limit=#{nrTracks}&mbid=#{artist_social_id}&api_key=#{get_api_key()}&format=json")
  end

  def valid_social_id(social_id) do
    case api_get("http://ws.audioscrobbler.com/2.0/?method=user.getinfo&mbid=#{"social_id"}&api_key=#{get_api_key()}&format=json") do
      {:ok, _} ->
        true
      {:error, _} ->
        false
    end
  end
end
