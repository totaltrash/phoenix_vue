import { createApp } from 'vue'
import { createPinia } from 'pinia'
import App from './App.vue'
import router from './router/index'

import urqlPlugin from '@urql/vue'
import { subscriptionExchange } from '@urql/core'
import { createClient as createGraphqlWs } from "graphql-ws"

const graphqlWs = createGraphqlWs({
  url: 'ws://localhost:4000/api/graphql-ws',
  lazy: false,
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

const app = createApp(App)
  .use(router())
  .use(createPinia())
  .use(urqlPlugin, urqlConfig)
  .mount('#app')
