defmodule Enysen.Repo.Migrations.CreateStreams do
  use Ecto.Migration

  def change do
    create table(:streams, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :title, :string
      add :start_time, :utc_datetime
      add :end_time, :utc_datetime
      add :channel_id, references(:channels, on_delete: :delete_all, type: :binary_id)

      timestamps()
    end
    create unique_index(:streams, [:end_time, :channel_id])
  end
end
