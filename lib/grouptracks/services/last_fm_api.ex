defmodule Grouptracks.Services.LastFmApi do
  def api_get(url) do
    case HTTPoison.get(url) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        result = Poison.decode!(body)
        if Map.has_key?(result, "error") do
          {:error, "API Error: #{result["message"]}"}
        else
          {:ok, result}
        end
      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, "Request Error: #{reason}"}
      _ ->
        {:error, "API Error"}
    end
  end

  def get_api_key() do
    Application.get_env(:grouptracks, :lastfm_api_key)
  end

  def get_user_top_artists(social_id, nr_artists \\ 10) do
    api_get("http://ws.audioscrobbler.com/2.0/?method=user.gettopartists&limit=#{nr_artists}&user=#{social_id}&api_key=#{get_api_key()}&format=json")
  end

  def get_similar_artists(artist_name, nr_artists \\ 10) do
    api_get("http://ws.audioscrobbler.com/2.0/?method=artist.getsimilar&limit=#{nr_artists}&artist=#{"artist_name"}&api_key=#{get_api_key()}&format=json")
  end

  def get_artist_top_tracks(artist_name, nr_tracks \\ 10) do
    api_get("http://ws.audioscrobbler.com/2.0/?method=artist.gettoptracks&limit=#{nr_tracks}&artist=#{artist_name}&api_key=#{get_api_key()}&format=json")
  end

  def valid_social_id(social_id) do
    api_get("http://ws.audioscrobbler.com/2.0/?method=user.getinfo&user=#{social_id}&api_key=#{get_api_key()}&format=json")
  end

  def get_user_top_artists!(social_id, nr_artists \\ 10) do
    {_, result} = api_get("http://ws.audioscrobbler.com/2.0/?method=user.gettopartists&limit=#{nr_artists}&user=#{social_id}&api_key=#{get_api_key()}&format=json")
    result
  end

  def get_similar_artists!(artist_name, nr_artists \\ 10) do
    {_, result} = api_get("http://ws.audioscrobbler.com/2.0/?method=artist.getsimilar&limit=#{nr_artists}&artist=#{"artist_name"}&api_key=#{get_api_key()}&format=json")
    result
  end

  def get_artist_top_tracks!(artist_name, nr_tracks \\ 10) do
    {_, result} = api_get("http://ws.audioscrobbler.com/2.0/?method=artist.gettoptracks&limit=#{nr_tracks}&artist=#{artist_name}&api_key=#{get_api_key()}&format=json")
    result
  end

  def valid_social_id(social_id) do
    api_get("http://ws.audioscrobbler.com/2.0/?method=user.getinfo&user=#{social_id}&api_key=#{get_api_key()}&format=json")
  end
end
