defmodule Enysen.Repo.Migrations.CreateFollowers do
  use Ecto.Migration

  def change do
    create table(:followers, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :user_id, references(:users, on_delete: :delete_all, type: :binary_id)
      add :follower_id, references(:users, on_delete: :delete_all, type: :binary_id)

      timestamps()
    end
    create(unique_index(:followers, [:follower_id, :user_id]))
  end
end
