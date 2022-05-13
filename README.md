# Phoenix + Vue3

Playing with embedding a Vue3 SPA in a Phoenix app. I am aiming to:

  - [x] Embed the SPA in a normal Phoenix template
  - [x] Use Phoenix to provide authentication to the SPA (using a modified version of phx_gen_auth)
  - [x] Connect the SPA to the Phoenix app using a web socket
  - [x] Decide on what mechanism to exchange data between the two sides (went with graphql, over the socket
  - [x] Use Ash + AshGraphql to provide the API from the Phoenix side
  - [ ] Protect the socket (using token authentication similar to the example in the Phoenix.Channels guide, but need to test)
  - [x] Use Pinia
  - [ ] Explore auto generating Pinia stores based on the Ash resources (probably no need as will be using the urql client directly, instead of hiding everything behind a store).
  - [x] Use Tailwind, Heroicons, HeadlessUI on the client

## To Do

Production build (of client)

Push to a production environment and check out how stable.

Review how I'm securing the socket (see handle_init in GraphqlSocket). Needs tests.

More client components (buttons, modals etc)

Full course crud example (with mutations)

Play with pushing messages from the server to the client (notifications or toasts etc)

Would like to explore an Ash client side api that emulates the Ash api, which can connect over a socket to call the Ash api. Haven't thought this through too much but, would be nice to replace Graphql as a data exchanger with something more Ash like

    const courses = ash.read("MyApp.Accounts", "MyApp.Accounts.Course", "read")

I'm currently sticking stuff like the user token and logout url into JS vars (see client/index.html.heex), and reading those in main.js (using the token to pass into the graphql client, not doing anything with the logout path yet). But, would be good to store this stuff in a pinia store (probably no need with the user token?). I'm sure there will be other stuff to pass from phoenix to js too.

Find some way to get the socket address from the router helper... doesn't look possible? Or provide the url as an environment variable. See client/index.html.heex

We're assigning the user to the absinthe context (GraphqlSocket.handle_init), but not yet using it. gotta test this when we get to authorization on the Ash side of stuff


## Reading

Installing Vue in a Phoenix app:

  - https://elixirforum.com/t/how-to-integrate-phoenix-1-6-with-vue-and-esbuild/45208
  - https://github.com/smpallen99/phx_vue3
  - https://dev.to/sethcalebweeks/phoenix-16-vue-esbuild-59i0
  - https://hexdocs.pm/phoenix/asset_management.html

Using Pinia with Axios to connect to an API:

  - https://blog.logrocket.com/consume-apis-with-vuex-pinia-axios/

## Graphql over websocket

Lots of reading out there that may be a little out of date. This post mentions a current way to go: https://elixirforum.com/t/graphql-with-absinthe-only-via-websockets-do-you-know-of-an-example/34899/5


  - https://github.com/enisdenjo/graphql-ws
  - https://hexdocs.pm/absinthe_graphql_ws/overview.html

Playing with URQL currently

  - https://formidable.com/open-source/urql/docs/basics/vue/
  - https://formidable.com/open-source/urql/docs/api/vue/

And... this fills in lots of blanks (using graphql-ws combined with urql):

  - https://github.com/FormidableLabs/urql/discussions/2190
  - https://github.com/andyrichardson/graphql-http-vs-ws/blob/master/frontend/src/benchmark.ts#L25
  - https://github.com/andyrichardson/graphql-http-vs-ws
  - https://dev.to/andyrichardsonn/graphql-requests-over-http-s-are-slow-d1p

More chat on graphql-ws:

  - https://www.the-guild.dev/blog/graphql-over-websockets

Pagination with Graphql:

  - https://daily.dev/blog/pagination-in-graphql

## Other graphql / websocket info

The following links may contain outdated info (some of the repos haven't been touched in 5years)

Note (old): AshGraphql is not involved in the *use* of the graphql api, it is handled solely by Absinthe, so something like the [@absinthe/socket-apollo-link](https://github.com/absinthe-graphql/absinthe-socket/tree/master/packages/socket-apollo-link) should be the go (although looks like it is out of date, see [this](https://github.com/absinthe-graphql/absinthe-socket/pull/58)).

  - https://www.apollographql.com/docs/react/api/link/apollo-link-subscriptions
  - https://www.apollographql.com/docs/react/api/link/community-links
  - https://github.com/vic/apollo-phoenix-websocket
  - https://github.com/absinthe-graphql/absinthe-socket/tree/master/packages/socket-apollo-link
  - https://github.com/absinthe-graphql/absinthe-socket/pull/58
  - https://dev.to/joehua87/simple-way-to-use-abinsthe-subscription-in-urql-1j59
