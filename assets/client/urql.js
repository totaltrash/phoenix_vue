import urqlPlugin from '@urql/vue'
import { subscriptionExchange } from '@urql/core'
import { createClient as createGraphqlWs } from "graphql-ws"

const graphqlWs = createGraphqlWs({
  url: window.graphql_ws_url,
  lazy: false,
  connectionParams: {
    token: window.user_token
  },
});

const urqlConfig = {
  url: "/",
  exchanges: [
    subscriptionExchange({
      enableAllOperations: true,
      forwardSubscription: (operation) => ({
        subscribe: (sink) => ({
          unsubscribe: graphqlWs.subscribe(operation, sink),
        }),
      }),
    }),
  ],
}

export {urqlPlugin, urqlConfig}
