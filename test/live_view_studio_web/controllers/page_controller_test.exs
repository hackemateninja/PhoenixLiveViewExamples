defmodule LiveViewStudioWeb.PageControllerTest do
  use LiveViewStudioWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, ~p"/")
    assert html_response(conn, 200) =~ "Projects"
  end
end
