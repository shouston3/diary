defmodule DiaryWeb.ViewHelpers do
  @doc"""
  Returns the current path for a given `conn`

  iex>js_file(%{request_path: "/"})
  "home.js"
  iex>js_file(%{request_path: "/settings"})
  "settings.js"
  """
  def js_file(%{request_path: "/"}),
    do: "home.js"
  def js_file(%{request_path: "/" <> file}),
    do: file <> ".js"
end
