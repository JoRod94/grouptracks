defmodule Grouptracks.Sharing.GroupUser do
  use Ecto.Schema
  import Ecto.Changeset


  schema "group_users" do
    field :user_id, :id
    field :group_id, :id

    timestamps()
  end

  @doc false
  def changeset(group_user, attrs) do
    group_user
    |> cast(attrs, [])
    |> validate_required([])
    |> foreign_key_constraint(:user_id)
    |> foreign_key_constraint(:group_id)
  end
end
