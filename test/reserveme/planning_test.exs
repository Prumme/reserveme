defmodule Reserveme.PlanningTest do
  use Reserveme.DataCase

  alias Reserveme.Planning

  describe "reservations" do
    alias Reserveme.Planning.Reservation

    import Reserveme.PlanningFixtures

    @invalid_attrs %{start: nil, end: nil, admin: nil, payed: nil, customer_comment: nil, admin_comment: nil}

    test "list_reservations/0 returns all reservations" do
      reservation = reservation_fixture()
      assert Planning.list_reservations() == [reservation]
    end

    test "get_reservation!/1 returns the reservation with given id" do
      reservation = reservation_fixture()
      assert Planning.get_reservation!(reservation.id) == reservation
    end

    test "create_reservation/1 with valid data creates a reservation" do
      valid_attrs = %{start: ~D[2023-08-07], end: ~D[2023-08-07], admin: true, payed: true, customer_comment: "some customer_comment", admin_comment: "some admin_comment"}

      assert {:ok, %Reservation{} = reservation} = Planning.create_reservation(valid_attrs)
      assert reservation.start == ~D[2023-08-07]
      assert reservation.end == ~D[2023-08-07]
      assert reservation.admin == true
      assert reservation.payed == true
      assert reservation.customer_comment == "some customer_comment"
      assert reservation.admin_comment == "some admin_comment"
    end

    test "create_reservation/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Planning.create_reservation(@invalid_attrs)
    end

    test "update_reservation/2 with valid data updates the reservation" do
      reservation = reservation_fixture()
      update_attrs = %{start: ~D[2023-08-08], end: ~D[2023-08-08], admin: false, payed: false, customer_comment: "some updated customer_comment", admin_comment: "some updated admin_comment"}

      assert {:ok, %Reservation{} = reservation} = Planning.update_reservation(reservation, update_attrs)
      assert reservation.start == ~D[2023-08-08]
      assert reservation.end == ~D[2023-08-08]
      assert reservation.admin == false
      assert reservation.payed == false
      assert reservation.customer_comment == "some updated customer_comment"
      assert reservation.admin_comment == "some updated admin_comment"
    end

    test "update_reservation/2 with invalid data returns error changeset" do
      reservation = reservation_fixture()
      assert {:error, %Ecto.Changeset{}} = Planning.update_reservation(reservation, @invalid_attrs)
      assert reservation == Planning.get_reservation!(reservation.id)
    end

    test "delete_reservation/1 deletes the reservation" do
      reservation = reservation_fixture()
      assert {:ok, %Reservation{}} = Planning.delete_reservation(reservation)
      assert_raise Ecto.NoResultsError, fn -> Planning.get_reservation!(reservation.id) end
    end

    test "change_reservation/1 returns a reservation changeset" do
      reservation = reservation_fixture()
      assert %Ecto.Changeset{} = Planning.change_reservation(reservation)
    end
  end
end
