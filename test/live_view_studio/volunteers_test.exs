defmodule LiveViewStudio.VolunteersTest do
  use LiveViewStudio.DataCase

  alias LiveViewStudio.Volunteers

  describe "volunteers" do
    alias LiveViewStudio.Volunteers.Volunteer

    import LiveViewStudio.VolunteersFixtures

    @invalid_attrs %{checked_out: nil, name: nil, phone: nil}

    test "list_volunteers/0 returns all volunteers" do
      volunteer = volunteer_fixture()
      assert Volunteers.list_volunteers() == [volunteer]
    end

    test "get_volunteer!/1 returns the volunteer with given id" do
      volunteer = volunteer_fixture()
      assert Volunteers.get_volunteer!(volunteer.id) == volunteer
    end

    test "create_volunteer/1 with valid data creates a volunteer" do
      valid_attrs = %{checked_out: true, name: "some name", phone: "303-555-1212"}

      assert {:ok, %Volunteer{} = volunteer} = Volunteers.create_volunteer(valid_attrs)
      assert volunteer.checked_out == true
      assert volunteer.name == "some name"
      assert volunteer.phone == "303-555-1212"
    end

    test "create_volunteer/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Volunteers.create_volunteer(@invalid_attrs)
    end

    test "update_volunteer/2 with valid data updates the volunteer" do
      volunteer = volunteer_fixture()
      update_attrs = %{checked_out: false, name: "some updated name", phone: "303-555-1213"}

      assert {:ok, %Volunteer{} = volunteer} =
               Volunteers.update_volunteer(volunteer, update_attrs)

      assert volunteer.checked_out == false
      assert volunteer.name == "some updated name"
      assert volunteer.phone == "303-555-1213"
    end

    test "update_volunteer/2 with invalid data returns error changeset" do
      volunteer = volunteer_fixture()
      assert {:error, %Ecto.Changeset{}} = Volunteers.update_volunteer(volunteer, @invalid_attrs)
      assert volunteer == Volunteers.get_volunteer!(volunteer.id)
    end

    test "delete_volunteer/1 deletes the volunteer" do
      volunteer = volunteer_fixture()
      assert {:ok, %Volunteer{}} = Volunteers.delete_volunteer(volunteer)
      assert_raise Ecto.NoResultsError, fn -> Volunteers.get_volunteer!(volunteer.id) end
    end

    test "change_volunteer/1 returns a volunteer changeset" do
      volunteer = volunteer_fixture()
      assert %Ecto.Changeset{} = Volunteers.change_volunteer(volunteer)
    end
  end
end
