defmodule Spotigroups.MusicTest do
  use Spotigroups.DataCase

  alias Spotigroups.Music

  describe "playlists" do
    alias Spotigroups.Music.Playlist
    alias Spotigroups.Sharing
    alias Spotigroups.Accounts

    @valid_attrs %{songs: [], spotify_id: "some spotify_id", group_id: 1}
    @update_attrs %{songs: [], spotify_id: "some updated spotify_id"}
    @invalid_attrs %{songs: nil, spotify_id: nil, group_id: nil}

    @valid_group_attrs %{name: "playlist_test", users: ["123", "456", "456"]}
    @test_user_sids ["123", "456"]

    def group_fixture(attrs \\ %{}) do
      Enum.each(@test_user_sids, fn us -> Accounts.create_user(%{social_id: us}) end)
      {:ok, group} =
        attrs
        |> Enum.into(@valid_group_attrs)
        |> Sharing.create_group()

      group
    end

    def playlist_fixture(attrs \\ %{}) do
      group = group_fixture()
      {:ok, playlist} =
        attrs
        |> Enum.into(%{@valid_attrs | group_id: group.id})
        |> Music.create_playlist()

      playlist
    end

    test "list_playlists/0 returns all playlists" do
      playlist = playlist_fixture()
      assert Music.list_playlists() == [playlist]
    end

    test "get_playlist!/1 returns the playlist with given id" do
      playlist = playlist_fixture()
      assert Music.get_playlist!(playlist.id) == playlist
    end

    test "create_playlist/1 with valid data creates a playlist" do
      group = group_fixture()
      assert {:ok, %Playlist{} = playlist} = Music.create_playlist(%{@valid_attrs | group_id: group.id})
      assert playlist.songs == []
      assert playlist.spotify_id == "some spotify_id"
      inserted_group = Sharing.get_group!(group.id) |> Repo.preload(:playlists)
      inserted_playlist_ids = Enum.map(inserted_group.playlists, fn p -> p.id end)
      assert Enum.member?(inserted_playlist_ids, playlist.id)
    end

    test "create_playlist/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Music.create_playlist(@invalid_attrs)
    end

    test "update_playlist/2 with valid data updates the playlist" do
      playlist = playlist_fixture()
      assert {:ok, playlist} = Music.update_playlist(playlist, @update_attrs)
      assert %Playlist{} = playlist
      assert playlist.songs == []
      assert playlist.spotify_id == "some updated spotify_id"
    end

    test "update_playlist/2 with invalid data returns error changeset" do
      playlist = playlist_fixture()
      assert {:error, %Ecto.Changeset{}} = Music.update_playlist(playlist, @invalid_attrs)
      assert playlist == Music.get_playlist!(playlist.id)
    end

    test "delete_playlist/1 deletes the playlist" do
      playlist = playlist_fixture()
      assert {:ok, %Playlist{}} = Music.delete_playlist(playlist)
      assert_raise Ecto.NoResultsError, fn -> Music.get_playlist!(playlist.id) end
    end

    test "change_playlist/1 returns a playlist changeset" do
      playlist = playlist_fixture()
      assert %Ecto.Changeset{} = Music.change_playlist(playlist)
    end
  end
end
