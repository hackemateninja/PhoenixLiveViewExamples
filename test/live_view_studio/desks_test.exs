defmodule LiveViewStudio.DesksTest do
  use LiveViewStudio.DataCase

  alias LiveViewStudio.Desks

  describe "desks" do
    alias LiveViewStudio.Desks.Desk

    import LiveViewStudio.DesksFixtures

    @invalid_attrs %{name: nil, photo_locations: nil}

    test "list_desks/0 returns all desks" do
      desk = desk_fixture()
      assert Desks.list_desks() == [desk]
    end

    test "get_desk!/1 returns the desk with given id" do
      desk = desk_fixture()
      assert Desks.get_desk!(desk.id) == desk
    end

    test "create_desk/1 with valid data creates a desk" do
      valid_attrs = %{name: "some name", photo_locations: []}

      assert {:ok, %Desk{} = desk} = Desks.create_desk(valid_attrs)
      assert desk.name == "some name"
      assert desk.photo_locations == []
    end

    test "create_desk/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Desks.create_desk(@invalid_attrs)
    end

    test "update_desk/2 with valid data updates the desk" do
      desk = desk_fixture()
      update_attrs = %{name: "some updated name", photo_locations: []}

      assert {:ok, %Desk{} = desk} = Desks.update_desk(desk, update_attrs)
      assert desk.name == "some updated name"
      assert desk.photo_locations == []
    end

    test "update_desk/2 with invalid data returns error changeset" do
      desk = desk_fixture()
      assert {:error, %Ecto.Changeset{}} = Desks.update_desk(desk, @invalid_attrs)
      assert desk == Desks.get_desk!(desk.id)
    end

    test "delete_desk/1 deletes the desk" do
      desk = desk_fixture()
      assert {:ok, %Desk{}} = Desks.delete_desk(desk)
      assert_raise Ecto.NoResultsError, fn -> Desks.get_desk!(desk.id) end
    end

    test "change_desk/1 returns a desk changeset" do
      desk = desk_fixture()
      assert %Ecto.Changeset{} = Desks.change_desk(desk)
    end
  end
end
