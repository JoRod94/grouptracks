# Grouptracks

An API to generate a playlist based on the tastes of a list of Last.fm users with a GraphQL API.

To set up the project:
  * Add your Last.fm API key to `dev.secret.exs` and `prod.secret.exs` files as such:
    ```
      use Mix.Config
      config :grouptracks, lastfm_api_key: <key>
    ```
  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Start Phoenix endpoint with `mix phx.server`
  * This API provides access through GraphQL. You can access it by using the GraphiQL IDE through http://localhost:4000/graphiql.

## Types, queries and mutations

The following types exist in this API:

| Type     | Fields                                                                                           |
|----------|--------------------------------------------------------------------------------------------------|
| User     | id: **ID**<br>socialId: **String**<br>groups: **[Group]**                                       |
| Group    | id: **ID**<br>name: **String**<br>playlists: **[Playlist]**<br>users: **[User]**                 |
| Playlist | id: **ID**<br>songs: **[String]**<br>spotifyId: **String**<br>groupId: **Group**                 |

Presently, the following queries are available:

| Query             | Type                                    |
|-------------------|-----------------------------------------|
| `allUsers`        | **[User]**                              |                                   
| `allGroups`       | **[Group]**                             |                                   
| `allPlaylists`    | **[Playlist]**                          | 


And the following mutations are available:

| Mutation            | Fields                                   |
|---------------------|------------------------------------------|
| `createUser`        | socialId: **String**                     |
| `createGroup`       | name: **String**<br>users: **[String]**  |
| `generatePlaylist`  | groupId: **Int**<br>nrTopArtists: **Int**|

## Example

A common use case would be to create a group and generate a playlist. To do so, you can the following sample sequence:

Create the two users (a group must have at least 2 users)
```
mutation {
  createUser(socialId: "yourlastfmid"){
    id
    socialId
  }
}
```
```
mutation {
  createUser(socialId: "anotherlastfmid"){
    id
    socialId
  }
}
```

Create a group with the two users:

```
mutation {
  createGroup(name: "groupname", users: ["yoursocialid", "othersocialid"]){
    id
    users {
      socialId
    }
    playlists{
      songs
    }
  }
}
```

Finally, generate a new playlist for that group (make sure the `groupId` is correct):

```
mutation {
  generatePlaylist(groupId: 1){
    id
    songs
  }
}
```