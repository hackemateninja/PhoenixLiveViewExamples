defmodule LiveViewStudio.AthletesTest do
  use LiveViewStudio.DataCase

  alias LiveViewStudio.Athletes

  describe "athletes" do
    alias LiveViewStudio.Athletes.Athlete

    import LiveViewStudio.AthletesFixtures

    @invalid_attrs %{emoji: nil, name: nil, sport: nil, status: nil}

    test "list_athletes/0 returns all athletes" do
      athlete = athlete_fixture()
      assert Athletes.list_athletes() == [athlete]
    end

    test "list_athletes/1 returns athletes filtered by sport" do
      surfing = athlete_fixture(sport: "surfing")
      _rowing = athlete_fixture(sport: "rowing")

      filter = %{sport: "surfing", status: ""}

      assert Athletes.list_athletes(filter) == [surfing]
    end

    test "list_athletes/1 returns athletes filtered by status" do
      training = athlete_fixture(status: "training")
      _resting = athlete_fixture(status: "resting")

      filter = %{sport: "", status: "training"}

      assert Athletes.list_athletes(filter) == [training]
    end

    test "list_athletes/1 returns athletes filtered by sport and status" do
      surfing_A = athlete_fixture(sport: "surfing", status: "training")
      _surfing_B = athlete_fixture(sport: "surfing", status: "resting")
      surfing_C = athlete_fixture(sport: "surfing", status: "training")
      _rowing = athlete_fixture(sport: "rowing", status: "training")

      filter = %{sport: "surfing", status: "training"}

      assert Athletes.list_athletes(filter) == [surfing_A, surfing_C]
    end

    test "get_athlete!/1 returns the athlete with given id" do
      athlete = athlete_fixture()
      assert Athletes.get_athlete!(athlete.id) == athlete
    end

    test "create_athlete/1 with valid data creates a athlete" do
      valid_attrs = %{
        emoji: "some emoji",
        name: "some name",
        sport: "rowing",
        status: "competing"
      }

      assert {:ok, %Athlete{} = athlete} = Athletes.create_athlete(valid_attrs)
      assert athlete.emoji == "some emoji"
      assert athlete.name == "some name"
      assert athlete.sport == "rowing"
      assert athlete.status == :competing
    end

    test "create_athlete/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Athletes.create_athlete(@invalid_attrs)
    end

    test "update_athlete/2 with valid data updates the athlete" do
      athlete = athlete_fixture()

      update_attrs = %{
        emoji: "some updated emoji",
        name: "some updated name",
        sport: "rowing",
        status: "training"
      }

      assert {:ok, %Athlete{} = athlete} = Athletes.update_athlete(athlete, update_attrs)
      assert athlete.emoji == "some updated emoji"
      assert athlete.name == "some updated name"
      assert athlete.sport == "rowing"
      assert athlete.status == :training
    end

    test "update_athlete/2 with invalid data returns error changeset" do
      athlete = athlete_fixture()
      assert {:error, %Ecto.Changeset{}} = Athletes.update_athlete(athlete, @invalid_attrs)
      assert athlete == Athletes.get_athlete!(athlete.id)
    end

    test "delete_athlete/1 deletes the athlete" do
      athlete = athlete_fixture()
      assert {:ok, %Athlete{}} = Athletes.delete_athlete(athlete)
      assert_raise Ecto.NoResultsError, fn -> Athletes.get_athlete!(athlete.id) end
    end

    test "change_athlete/1 returns a athlete changeset" do
      athlete = athlete_fixture()
      assert %Ecto.Changeset{} = Athletes.change_athlete(athlete)
    end
  end
end
