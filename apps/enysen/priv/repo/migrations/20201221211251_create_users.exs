defmodule Enysen.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :email, :string, null: false
      add :password_hash, :string
      add :username, :string, null: false
      add :stream_key, :string, null: false
      add :stream_title, :string
      add :bio, :string

      timestamps()
    end

    create unique_index(:users, [:email])
    create unique_index(:users, [:username])
    create unique_index(:users, [:stream_key])
  end
end
