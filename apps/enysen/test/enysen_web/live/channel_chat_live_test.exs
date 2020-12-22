defmodule EnysenWeb.ChannelChatLiveTest do
  use EnysenWeb.ConnCase

  import Phoenix.LiveViewTest

  alias Enysen.Social

  @create_attrs %{body: "some body", user: "some user"}
  @update_attrs %{body: "some updated body", user: "some updated user"}
  @invalid_attrs %{body: nil, user: nil}

  defp fixture(:channel_chat) do
    {:ok, channel_chat} = Social.create_channel_chat(@create_attrs)
    channel_chat
  end

  defp create_channel_chat(_) do
    channel_chat = fixture(:channel_chat)
    %{channel_chat: channel_chat}
  end

  describe "Index" do
    setup [:create_channel_chat]

    test "lists all channel_chats", %{conn: conn, channel_chat: channel_chat} do
      {:ok, _index_live, html} = live(conn, Routes.channel_chat_index_path(conn, :index))

      assert html =~ "Listing Channel chats"
      assert html =~ channel_chat.body
    end

    test "saves new channel_chat", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.channel_chat_index_path(conn, :index))

      assert index_live |> element("a", "New Channel chat") |> render_click() =~
               "New Channel chat"

      assert_patch(index_live, Routes.channel_chat_index_path(conn, :new))

      assert index_live
             |> form("#channel_chat-form", channel_chat: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#channel_chat-form", channel_chat: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.channel_chat_index_path(conn, :index))

      assert html =~ "Channel chat created successfully"
      assert html =~ "some body"
    end

    test "updates channel_chat in listing", %{conn: conn, channel_chat: channel_chat} do
      {:ok, index_live, _html} = live(conn, Routes.channel_chat_index_path(conn, :index))

      assert index_live |> element("#channel_chat-#{channel_chat.id} a", "Edit") |> render_click() =~
               "Edit Channel chat"

      assert_patch(index_live, Routes.channel_chat_index_path(conn, :edit, channel_chat))

      assert index_live
             |> form("#channel_chat-form", channel_chat: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#channel_chat-form", channel_chat: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.channel_chat_index_path(conn, :index))

      assert html =~ "Channel chat updated successfully"
      assert html =~ "some updated body"
    end

    test "deletes channel_chat in listing", %{conn: conn, channel_chat: channel_chat} do
      {:ok, index_live, _html} = live(conn, Routes.channel_chat_index_path(conn, :index))

      assert index_live |> element("#channel_chat-#{channel_chat.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#channel_chat-#{channel_chat.id}")
    end
  end

  describe "Show" do
    setup [:create_channel_chat]

    test "displays channel_chat", %{conn: conn, channel_chat: channel_chat} do
      {:ok, _show_live, html} = live(conn, Routes.channel_chat_show_path(conn, :show, channel_chat))

      assert html =~ "Show Channel chat"
      assert html =~ channel_chat.body
    end

    test "updates channel_chat within modal", %{conn: conn, channel_chat: channel_chat} do
      {:ok, show_live, _html} = live(conn, Routes.channel_chat_show_path(conn, :show, channel_chat))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Channel chat"

      assert_patch(show_live, Routes.channel_chat_show_path(conn, :edit, channel_chat))

      assert show_live
             |> form("#channel_chat-form", channel_chat: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#channel_chat-form", channel_chat: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.channel_chat_show_path(conn, :show, channel_chat))

      assert html =~ "Channel chat updated successfully"
      assert html =~ "some updated body"
    end
  end
end
