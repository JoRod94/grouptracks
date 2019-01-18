defmodule Grouptracks.Repo.Migrations.CreateGroupUsers do
  use Ecto.Migration

  def change do
    create table(:group_users) do
      # Unclear if 'on_delete: :delete_all' should be added only here, only in the schema, or in both. Keeping in both to be safe
      add :user_id, references(:users, on_delete: :delete_all)
      add :group_id, references(:groups, on_delete: :delete_all)

      timestamps()
    end

    create unique_index(:group_users, [:user_id, :group_id])
  end
end
