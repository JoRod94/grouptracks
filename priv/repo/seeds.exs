# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Spotigroups.Repo.insert!(%Spotigroups.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Spotigroups.Accounts.User
alias Spotigroups.Repo

%User{ spotify_id: "1166739979"} |> Repo.insert!