defmodule Reserveme.Repo.Migrations.CreateReservations do
  use Ecto.Migration

  def change do
    create table(:reservations) do
      add :start, :date
      add :end, :date
      add :admin, :boolean, default: false, null: false
      add :payed, :boolean, default: false, null: false
      add :customer_comment, :text
      add :admin_comment, :text
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:reservations, [:user_id])
  end
end
