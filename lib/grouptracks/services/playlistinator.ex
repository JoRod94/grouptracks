defmodule Grouptracks.Services.Playlistinator do
  alias Grouptracks.Sharing
  alias Grouptracks.Music
  alias Grouptracks.Services.LastFmApi
  alias Grouptracks.Repo

  def top_common_artists(users, nr_artists) do
    ranking = users
      |> Enum.reduce(%{}, fn u, leaderboard -> 
        LastFmApi.get_user_top_artists!(u.social_id, nr_artists)["topartists"]["artist"]
          |> Enum.reduce(leaderboard, fn a, l ->
            artist_name = a["name"]
            artist_rank = nr_artists - String.to_integer(a["@attr"]["rank"])
            if Map.has_key?(l, artist_name) do
              artist_nr_users = elem(l[artist_name], 2) + 1
              artist_new_rank = elem(l[artist_name], 1) + artist_rank*artist_nr_users
              Map.put(l, artist_name, {artist_name, artist_new_rank, artist_nr_users})
            else
              artist_nr_users = 1
              Map.put(l, artist_name, {artist_name, artist_rank, artist_nr_users})
            end
          end)
      end)
    ranking 
      |> Map.values
      |> Enum.filter(fn a -> elem(a, 2) > 0.34*length(users) end)
      |> Enum.sort(fn s1, s2 -> elem(s1, 1) > elem(s2, 1) end) 
      |> Enum.map(fn s -> elem(s, 0) end) 
      |> Enum.take(nr_artists)
  end

  def get_top_songs(artists) do
    nr_artists = length(artists)
    {_, top_songs} = artists 
      |> Enum.reduce({0, []}, fn(a, {index, songs}) ->
          artist_songs = LastFmApi.get_artist_top_tracks!(a, nr_artists-index)["toptracks"]["track"] 
            |> Enum.map(fn t -> {a, t["name"]} end)
          {index+1, songs ++ artist_songs}
      end)
    top_songs |> Enum.map(fn t -> "#{elem(t, 0)} - #{elem(t, 1)}" end)
  end

  def generate_playlist(group_id, nr_top_artists) do 
    group = Sharing.get_group!(group_id) |> Repo.preload(:users)
    top_common_artists = top_common_artists(group.users, nr_top_artists)
    songs = get_top_songs(top_common_artists)
    Music.create_playlist(%{group_id: group_id, songs: songs})
  end
end
