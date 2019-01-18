defmodule Spotigroups.Accounts.User do
  alias Spotigroups.Services.LastFmApi
  alias Ecto.Changeset
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :social_id, :string
    many_to_many :groups, Spotigroups.Sharing.Group, join_through: Spotigroups.Sharing.GroupUser, on_delete: :delete_all, on_replace: :delete

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:social_id])
    |> validate_required([:social_id])
    |> unique_constraint(:social_id)
    |> validate_user_id(:social_id)
  end

  defp validate_user_id(changeset, attrs) do
    if Application.get_env(:spotigroups, :current_env) != :test do
      case LastFmApi.valid_social_id(changeset.changes[:social_id]) do
        {:ok, _} ->
          changeset
        {:error, msg} ->
          add_error(changeset, :users, "User does not exist")
      end
    else
      changeset
    end
  end
end