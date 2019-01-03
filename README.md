# Spotigroups

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Start Phoenix endpoint with `mix phx.server`

This API provides access through GraphQL. As such, you can access it by using the GraphiQL IDE through http://localhost:4000/graphiql.

The following types exist in this API:

| Type     | Fields                                                                                           |
|----------|--------------------------------------------------------------------------------------------------|
| User     | id: **ID**<br>spotifyID: **String**<br>groups: **[Group]**                                       |
| Group    | id: **ID**<br>name: **String**<br>playlists: **[Playlist]**<br>users: **[User]**                 |
| Playlist | id: **ID**<br>songs: **[String]**<br>spotifyId: **String**<br>groupId: **Group**                 |

Presently, the following queries are available:

| Query             | Type                                    |
|-------------------|-----------------------------------------|
| `allUsers`        | **[User]**                              |                                   
| `allGroups`       | **[Group]**                             |                                   
| `allPlaylists`    | **[Playlist]**                          | 


And the following mutations are available:

| Mutation            | Fields                                  | Notes                             |
|---------------------|-----------------------------------------|-----------------------------------|
| `createUser`        | spotifyId: **String**                   |                                   |
| `createGroup`       | name: **String**<br>users: **[String]** |                                   |
| `generatePlaylist`  | groupId: **Int**                        | Generated playlist is placeholder |
