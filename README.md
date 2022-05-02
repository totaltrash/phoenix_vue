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
