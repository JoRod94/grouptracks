defmodule Spotigroups.Sharing.Group do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query, warn: false
  alias Ecto.Changeset


  schema "groups" do
    field :name, :string
    has_many :playlists, Spotigroups.Music.Playlist, on_delete: :delete_all, on_replace: :delete
    many_to_many :users, Spotigroups.Accounts.User, join_through: Spotigroups.Sharing.GroupUser, on_delete: :delete_all, on_replace: :delete

    timestamps()
  end

  @doc false
  def changeset(group, attrs) do
    group
    |> cast(attrs, [:name])
    |> validate_required([:name])
    |> validate_user_ids_presence(attrs)
    |> validate_user_ids_length(attrs)
    |> add_users(attrs)
    # |> unique_constraint(:users)
  end

  defp validate_user_ids_presence(%Changeset{valid?: true} = changeset, attrs) do
    if !Map.has_key?(attrs, :users) do
      add_error(changeset, :users, "Missing Users Argument")
    else
      changeset
    end
  end

  defp validate_user_ids_length(%Changeset{valid?: true} = changeset, attrs) do
    if Enum.uniq(attrs.users) |> length < 2 do
      add_error(changeset, :users, "You can only create a group with at least 2 distinct users")
    else
      changeset
    end
  end

  defp add_users(%Changeset{valid?: true} = changeset, attrs) do
    changeset |> put_assoc(:users, attrs.users)
  end

 defp validate_user_ids_length(changeset, _), do: changeset 
 defp validate_user_ids_presence(changeset, _), do: changeset 
 defp add_users(changeset, _), do: changeset 

end
