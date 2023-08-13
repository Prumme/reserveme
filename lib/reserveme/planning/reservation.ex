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
    field :lodger, :integer
    belongs_to :user, Reserveme.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(reservation, attrs) do
    reservation
    |> cast(attrs, [:start, :end, :admin, :payed, :customer_comment, :admin_comment, :lodger, :user_id])
    |> validate_required([:start, :end, :lodger,])
  end
end
