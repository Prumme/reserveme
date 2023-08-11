defmodule Reserveme.Planning.Reservation do
  use Ecto.Schema
  import Ecto.Changeset

  schema "reservations" do
    field :start, :date
    field :end, :date
    field :admin, :boolean, default: false
    field :payed, :boolean, default: false
    field :customer_comment, :string
    field :admin_comment, :string
    field :user_id, :id

    timestamps()
  end

  @doc false
  def changeset(reservation, attrs) do
    reservation
    |> cast(attrs, [:start, :end, :admin, :payed, :customer_comment, :admin_comment])
    |> validate_required([:start, :end, :admin, :payed, :customer_comment, :admin_comment])
  end
end
