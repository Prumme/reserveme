defmodule Reserveme.PlanningFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Reserveme.Planning` context.
  """

  @doc """
  Generate a reservation.
  """
  def reservation_fixture(attrs \\ %{}) do
    {:ok, reservation} =
      attrs
      |> Enum.into(%{
        start: ~D[2023-08-07],
        end: ~D[2023-08-07],
        admin: true,
        payed: true,
        customer_comment: "some customer_comment",
        admin_comment: "some admin_comment"
      })
      |> Reserveme.Planning.create_reservation()

    reservation
  end
end
