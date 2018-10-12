defmodule SpotigroupsWeb.SharingResolver do
  alias Spotigroups.Sharing

  def all_groups(_root, _args, _info) do
    groups = Sharing.list_groups()
    {:ok, groups}
  end

  def create_group(_root, args, _info) do
  # TODO: add detailed error message handling later
    case Sharing.create_group(args) do
      {:ok, group} ->
        {:ok, group}
      {:error, x} ->
        {:error, x}
    end
  end
end