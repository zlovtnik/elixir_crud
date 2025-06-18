defmodule ErpWeb.View do
  @moduledoc """
  Provides shared view helpers for Phoenix views.
  """
  def render(view, template, assigns) do
    Phoenix.View.render(view, template, assigns)
  end
end
