# Phoenix + Vue3

Playing with embedding a Vue3 SPA in a Phoenix app. I am aiming to:

  - [x] Embed the SPA in a normal Phoenix template
  - [x] Use Phoenix to provide authentication to the SPA (using a modified version of phx_gen_auth)
  - [ ] Connect the SPA to the Phoenix app using a web socket
  - [ ] Decide on what mechanism to exchange data between the two apps (probably graphql, over the socket)
  - [ ] Use Ash (and if I use Graphql, AshGraphql) to provide the API from the Phoenix side
  - [x] Use Pinia
  - [ ] Explore auto generating Pinia stores based on the Ash resources
  - [x] Use Tailwind, Heroicons, HeadlessUI on the client

## Reading

Installing Vue in a Phoenix app:

  - https://elixirforum.com/t/how-to-integrate-phoenix-1-6-with-vue-and-esbuild/45208
  - https://github.com/smpallen99/phx_vue3
  - https://dev.to/sethcalebweeks/phoenix-16-vue-esbuild-59i0
  - https://hexdocs.pm/phoenix/asset_management.html

Using Pinia with Axios to connect to an API:

  - https://blog.logrocket.com/consume-apis-with-vuex-pinia-axios/

## Apollo over websocket

Lots of reading out there that may be a little out of date. This post mentions a current way to go: https://elixirforum.com/t/graphql-with-absinthe-only-via-websockets-do-you-know-of-an-example/34899/5

The following links may contain outdated info (some of the repos haven't been touched in 5years)

Note (old): AshGraphql is not involved in the *use* of the graphql api, it is handled solely by Absinthe, so something like the [@absinthe/socket-apollo-link](https://github.com/absinthe-graphql/absinthe-socket/tree/master/packages/socket-apollo-link) should be the go (although looks like it is out of date, see [this](https://github.com/absinthe-graphql/absinthe-socket/pull/58)).

  - https://www.apollographql.com/docs/react/api/link/apollo-link-subscriptions
  - https://www.apollographql.com/docs/react/api/link/community-links
  - https://github.com/vic/apollo-phoenix-websocket
  - https://github.com/absinthe-graphql/absinthe-socket/tree/master/packages/socket-apollo-link
  - https://github.com/absinthe-graphql/absinthe-socket/pull/58
  - https://dev.to/joehua87/simple-way-to-use-abinsthe-subscription-in-urql-1j59
