defmodule Enysen.SocialTest do
  use Enysen.DataCase

  alias Enysen.Social

  describe "channel_chats" do
    alias Enysen.Social.ChannelChat

    @valid_attrs %{body: "some body", user: "some user"}
    @update_attrs %{body: "some updated body", user: "some updated user"}
    @invalid_attrs %{body: nil, user: nil}

    def channel_chat_fixture(attrs \\ %{}) do
      {:ok, channel_chat} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Social.create_channel_chat()

      channel_chat
    end

    test "list_channel_chats/0 returns all channel_chats" do
      channel_chat = channel_chat_fixture()
      assert Social.list_channel_chats() == [channel_chat]
    end

    test "get_channel_chat!/1 returns the channel_chat with given id" do
      channel_chat = channel_chat_fixture()
      assert Social.get_channel_chat!(channel_chat.id) == channel_chat
    end

    test "create_channel_chat/1 with valid data creates a channel_chat" do
      assert {:ok, %ChannelChat{} = channel_chat} = Social.create_channel_chat(@valid_attrs)
      assert channel_chat.body == "some body"
      assert channel_chat.user == "some user"
    end

    test "create_channel_chat/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Social.create_channel_chat(@invalid_attrs)
    end

    test "update_channel_chat/2 with valid data updates the channel_chat" do
      channel_chat = channel_chat_fixture()
      assert {:ok, %ChannelChat{} = channel_chat} = Social.update_channel_chat(channel_chat, @update_attrs)
      assert channel_chat.body == "some updated body"
      assert channel_chat.user == "some updated user"
    end

    test "update_channel_chat/2 with invalid data returns error changeset" do
      channel_chat = channel_chat_fixture()
      assert {:error, %Ecto.Changeset{}} = Social.update_channel_chat(channel_chat, @invalid_attrs)
      assert channel_chat == Social.get_channel_chat!(channel_chat.id)
    end

    test "delete_channel_chat/1 deletes the channel_chat" do
      channel_chat = channel_chat_fixture()
      assert {:ok, %ChannelChat{}} = Social.delete_channel_chat(channel_chat)
      assert_raise Ecto.NoResultsError, fn -> Social.get_channel_chat!(channel_chat.id) end
    end

    test "change_channel_chat/1 returns a channel_chat changeset" do
      channel_chat = channel_chat_fixture()
      assert %Ecto.Changeset{} = Social.change_channel_chat(channel_chat)
    end
  end
end
