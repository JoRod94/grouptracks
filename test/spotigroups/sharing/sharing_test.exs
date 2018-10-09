defmodule Spotigroups.SharingTest do
  use Spotigroups.DataCase

  alias Spotigroups.Sharing

  describe "groups" do
    alias Spotigroups.Sharing.Group

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def group_fixture(attrs \\ %{}) do
      {:ok, group} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Sharing.create_group()

      group
    end

    test "list_groups/0 returns all groups" do
      group = group_fixture()
      assert Sharing.list_groups() == [group]
    end

    test "get_group!/1 returns the group with given id" do
      group = group_fixture()
      assert Sharing.get_group!(group.id) == group
    end

    test "create_group/1 with valid data creates a group" do
      assert {:ok, %Group{} = group} = Sharing.create_group(@valid_attrs)
      assert group.name == "some name"
    end

    test "create_group/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Sharing.create_group(@invalid_attrs)
    end

    test "update_group/2 with valid data updates the group" do
      group = group_fixture()
      assert {:ok, group} = Sharing.update_group(group, @update_attrs)
      assert %Group{} = group
      assert group.name == "some updated name"
    end

    test "update_group/2 with invalid data returns error changeset" do
      group = group_fixture()
      assert {:error, %Ecto.Changeset{}} = Sharing.update_group(group, @invalid_attrs)
      assert group == Sharing.get_group!(group.id)
    end

    test "delete_group/1 deletes the group" do
      group = group_fixture()
      assert {:ok, %Group{}} = Sharing.delete_group(group)
      assert_raise Ecto.NoResultsError, fn -> Sharing.get_group!(group.id) end
    end

    test "change_group/1 returns a group changeset" do
      group = group_fixture()
      assert %Ecto.Changeset{} = Sharing.change_group(group)
    end
  end

  describe "group_users" do
    alias Spotigroups.Sharing.GroupUser

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def group_user_fixture(attrs \\ %{}) do
      {:ok, group_user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Sharing.create_group_user()

      group_user
    end

    test "list_group_users/0 returns all group_users" do
      group_user = group_user_fixture()
      assert Sharing.list_group_users() == [group_user]
    end

    test "get_group_user!/1 returns the group_user with given id" do
      group_user = group_user_fixture()
      assert Sharing.get_group_user!(group_user.id) == group_user
    end

    test "create_group_user/1 with valid data creates a group_user" do
      assert {:ok, %GroupUser{} = group_user} = Sharing.create_group_user(@valid_attrs)
    end

    # test "create_group_user/1 with invalid data returns error changeset" do
    #   assert {:error, %Ecto.Changeset{}} = Sharing.create_group_user(@invalid_attrs)
    # end

    test "update_group_user/2 with valid data updates the group_user" do
      group_user = group_user_fixture()
      assert {:ok, group_user} = Sharing.update_group_user(group_user, @update_attrs)
      assert %GroupUser{} = group_user
    end

    # test "update_group_user/2 with invalid data returns error changeset" do
    #   group_user = group_user_fixture()
    #   assert {:error, %Ecto.Changeset{}} = Sharing.update_group_user(group_user, @invalid_attrs)
    #   assert group_user == Sharing.get_group_user!(group_user.id)
    # end

    test "delete_group_user/1 deletes the group_user" do
      group_user = group_user_fixture()
      assert {:ok, %GroupUser{}} = Sharing.delete_group_user(group_user)
      assert_raise Ecto.NoResultsError, fn -> Sharing.get_group_user!(group_user.id) end
    end

    test "change_group_user/1 returns a group_user changeset" do
      group_user = group_user_fixture()
      assert %Ecto.Changeset{} = Sharing.change_group_user(group_user)
    end
  end
end
