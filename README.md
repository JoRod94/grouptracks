# Spotigroups

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Start Phoenix endpoint with `mix phx.server`

This API provides access through GraphQL. As such, you can access it by using the GraphiQL IDE through http://localhost:4000/graphiql.

Presently, the following queries are available:

- `all_users`
- `all_groups`
- `all_playlists`

And the following mutations are available:

| Mutation          | Args                                | Notes                             |
|-------------------|-------------------------------------|-----------------------------------|
| `create_user`       | spotify_id:string                   |                                   |
| `create_group`      | name:string, users:list_of(:string) |                                   |
| `generate_playlist` | group_id:integer                    | Generated playlist is placeholder |
