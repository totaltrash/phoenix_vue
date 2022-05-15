import { createApp } from 'vue'
import { createPinia } from 'pinia'
import App from '~/App.vue'
import router from '~/router'
import { urqlPlugin, urqlConfig } from '~/urql'

createApp(App)
  .use(router)
  .use(createPinia())
  .use(urqlPlugin, urqlConfig)
  .mount('#app')
