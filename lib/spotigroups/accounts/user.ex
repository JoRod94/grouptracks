defmodule Spotigroups.Accounts.User do
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
  end
end
