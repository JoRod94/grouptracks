defmodule Spotigroups.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset


  schema "users" do
    field :spotify_id, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:spotify_id])
    |> validate_required([:spotify_id])
  end
end
