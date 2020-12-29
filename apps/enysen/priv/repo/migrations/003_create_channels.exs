defmodule Enysen.Repo.Migrations.CreateChannels do
  use Ecto.Migration

  def change do
    create table(:channels, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :user_id, references(:users, on_delete: :delete_all, type: :binary_id)
      add :stream_title, :string
      add :stream_key, :string
      add :bio, :string

      timestamps()
    end
    create unique_index(:channels, [:user_id])
    create unique_index(:channels, [:stream_key])
  end
end
