defmodule Test.FeatureHelpers do
  use Wallaby.DSL

  import ExUnit.Assertions

  # Page helpers

  def page_header(title), do: Query.data("role", "header-title", text: title)
  def modal_header(title), do: Query.data("role", "modal-title", text: title)

  # Form helpers

  @doc """
  Set a selectable (checkbox, radio, option) to a given value.

      set(Query.checkbox("Some checkbox"), true)
  """
  def set(session, checkbox, true) do
    if selected?(session, checkbox) do
      session
    else
      click(session, checkbox)
    end
  end

  def set(session, checkbox, false) do
    if selected?(session, checkbox) do
      click(session, checkbox)
    else
      session
    end
  end

  # Assertions

  def assert_field_value(session, field, value) do
    # session
    # |> find(Query.text_field("Filter"), fn field ->
    #   assert Element.value(field) == filter
    # end)

    assert attr(session, Query.text_field(field), :value) == value

    session
  end

  def assert_select_value(session, field, value) do
    assert attr(session, Query.select(field), :value) == to_string(value)

    session
  end

  def assert_flash_message(session, message) do
    session
    # |> find(Query.attribute("phx-feedback-for", "#{to_string(field_id)}"))
    |> assert_text(message)

    session
  end

  def assert_has_form_error(session, field_id, error) do
    session
    |> find(Query.attribute("phx-feedback-for", "#{to_string(field_id)}"))
    |> assert_text(error)

    session
  end

  def assert_forbidden(session) do
    session
    |> assert_text("Access denied")
  end
end
