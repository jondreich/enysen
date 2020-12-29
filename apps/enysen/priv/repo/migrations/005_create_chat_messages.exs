defmodule Enysen.Repo.Migrations.CreateChatMessages do
  use Ecto.Migration

  def change do
    create table(:chat_messages, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :user_id, references(:users, type: :binary_id)
      add :stream_id, references(:streams, on_delete: :delete_all, type: :binary_id)
      add :body, :string

      timestamps()
    end

  end
end
