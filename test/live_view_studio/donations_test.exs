defmodule LiveViewStudio.DonationsTest do
  use LiveViewStudio.DataCase

  alias LiveViewStudio.Donations

  describe "donations" do
    alias LiveViewStudio.Donations.Donation

    import LiveViewStudio.DonationsFixtures

    @invalid_attrs %{days_until_expires: nil, emoji: nil, item: nil, quantity: nil}

    test "list_donations/0 returns all donations" do
      donation = donation_fixture()
      assert Donations.list_donations() == [donation]
    end

    test "list_donations/1 returns donations in sorted order" do
      c = donation_fixture(item: "c", quantity: 2)
      a = donation_fixture(item: "a", quantity: 3)
      b = donation_fixture(item: "b", quantity: 1)

      options = %{sort_by: :item, sort_order: :asc}

      assert Donations.list_donations(options) == [a, b, c]

      options = %{sort_by: :quantity, sort_order: :desc}

      assert Donations.list_donations(options) == [a, c, b]
    end

    test "list_donations/1 returns donations in pages" do
      a = donation_fixture(item: "a")
      b = donation_fixture(item: "b")
      c = donation_fixture(item: "c")
      d = donation_fixture(item: "d")
      e = donation_fixture(item: "e")

      options = %{page: 1, per_page: 10}

      assert Donations.list_donations(options) == [a, b, c, d, e]

      options = %{page: 2, per_page: 2}

      assert Donations.list_donations(options) == [c, d]

      options = %{page: 3, per_page: 1}

      assert Donations.list_donations(options) == [c]
    end

    test "get_donation!/1 returns the donation with given id" do
      donation = donation_fixture()
      assert Donations.get_donation!(donation.id) == donation
    end

    test "create_donation/1 with valid data creates a donation" do
      valid_attrs = %{
        days_until_expires: 42,
        emoji: "some emoji",
        item: "some item",
        quantity: 42
      }

      assert {:ok, %Donation{} = donation} = Donations.create_donation(valid_attrs)
      assert donation.days_until_expires == 42
      assert donation.emoji == "some emoji"
      assert donation.item == "some item"
      assert donation.quantity == 42
    end

    test "create_donation/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Donations.create_donation(@invalid_attrs)
    end

    test "update_donation/2 with valid data updates the donation" do
      donation = donation_fixture()

      update_attrs = %{
        days_until_expires: 43,
        emoji: "some updated emoji",
        item: "some updated item",
        quantity: 43
      }

      assert {:ok, %Donation{} = donation} = Donations.update_donation(donation, update_attrs)
      assert donation.days_until_expires == 43
      assert donation.emoji == "some updated emoji"
      assert donation.item == "some updated item"
      assert donation.quantity == 43
    end

    test "update_donation/2 with invalid data returns error changeset" do
      donation = donation_fixture()
      assert {:error, %Ecto.Changeset{}} = Donations.update_donation(donation, @invalid_attrs)
      assert donation == Donations.get_donation!(donation.id)
    end

    test "delete_donation/1 deletes the donation" do
      donation = donation_fixture()
      assert {:ok, %Donation{}} = Donations.delete_donation(donation)
      assert_raise Ecto.NoResultsError, fn -> Donations.get_donation!(donation.id) end
    end

    test "change_donation/1 returns a donation changeset" do
      donation = donation_fixture()
      assert %Ecto.Changeset{} = Donations.change_donation(donation)
    end
  end
end
