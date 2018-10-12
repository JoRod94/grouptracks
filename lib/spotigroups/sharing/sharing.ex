defmodule Spotigroups.Sharing do
  @moduledoc """
  The Sharing context.
  """

  import Ecto.Query, warn: false
  alias Spotigroups.Repo

  alias Spotigroups.Sharing.Group
  alias Spotigroups.Accounts.User
  alias Ecto.Changeset

  @doc """
  Returns the list of groups.

  ## Examples

      iex> list_groups()
      [%Group{}, ...]

  """
  def list_groups do
    Repo.all(Group)
  end

  @doc """
  Gets a single group.

  Raises `Ecto.NoResultsError` if the Group does not exist.

  ## Examples

      iex> get_group!(123)
      %Group{}

      iex> get_group!(456)
      ** (Ecto.NoResultsError)

  """
  def get_group!(id), do: Repo.get!(Group, id)

  @doc """
  Creates a group.

  ## Examples

      iex> create_group(%{field: value})
      {:ok, %Group{}}

      iex> create_group(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_group(attrs \\ %{}) do
    if !Map.has_key?(attrs, :users) do
      {:error, "No Users Argument"}
    else
      group_users = Repo.all(from u in User, where: u.spotify_id in ^attrs.users, select: u)
      if length(attrs.users) != length(group_users) do
        {:error, "Missing User(s)"}
      else
        inserted_group = %Group{}
        |> Group.changeset(attrs)
        |> Repo.insert!()
        |> Repo.preload :users

        Changeset.change(inserted_group)
        |> Changeset.put_assoc(:users, group_users)
        |> Repo.update()
      end
    end
  end

  @doc """
  Updates a group.

  ## Examples

      iex> update_group(group, %{field: new_value})
      {:ok, %Group{}}

      iex> update_group(group, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_group(%Group{} = group, attrs) do
    group
    |> Group.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Group.

  ## Examples

      iex> delete_group(group)
      {:ok, %Group{}}

      iex> delete_group(group)
      {:error, %Ecto.Changeset{}}

  """
  def delete_group(%Group{} = group) do
    Repo.delete(group)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking group changes.

  ## Examples

      iex> change_group(group)
      %Ecto.Changeset{source: %Group{}}

  """
  def change_group(%Group{} = group) do
    Group.changeset(group, %{})
  end

  alias Spotigroups.Sharing.GroupUser

  @doc """
  Returns the list of group_users.

  ## Examples

      iex> list_group_users()
      [%GroupUser{}, ...]

  """
  def list_group_users do
    Repo.all(GroupUser)
  end

  @doc """
  Gets a single group_user.

  Raises `Ecto.NoResultsError` if the Group user does not exist.

  ## Examples

      iex> get_group_user!(123)
      %GroupUser{}

      iex> get_group_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_group_user!(id), do: Repo.get!(GroupUser, id)

  @doc """
  Creates a group_user.

  ## Examples

      iex> create_group_user(%{field: value})
      {:ok, %GroupUser{}}

      iex> create_group_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_group_user(attrs \\ %{}) do
    %GroupUser{}
    |> GroupUser.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a group_user.

  ## Examples

      iex> update_group_user(group_user, %{field: new_value})
      {:ok, %GroupUser{}}

      iex> update_group_user(group_user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_group_user(%GroupUser{} = group_user, attrs) do
    group_user
    |> GroupUser.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a GroupUser.

  ## Examples

      iex> delete_group_user(group_user)
      {:ok, %GroupUser{}}

      iex> delete_group_user(group_user)
      {:error, %Ecto.Changeset{}}

  """
  def delete_group_user(%GroupUser{} = group_user) do
    Repo.delete(group_user)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking group_user changes.

  ## Examples

      iex> change_group_user(group_user)
      %Ecto.Changeset{source: %GroupUser{}}

  """
  def change_group_user(%GroupUser{} = group_user) do
    GroupUser.changeset(group_user, %{})
  end
end
