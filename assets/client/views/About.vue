<template>
  <h1 data-role="header-title" class="text-3xl font-bold">About</h1>
  <ul>
    <li v-for="post in posts" :key="post.id">
      {{ post.id }} {{ post.title }}
    </li>
  </ul>
</template>

<script>

import { useStore } from '../stores/store'
import { storeToRefs } from 'pinia'

export default {
  setup() {
    const store = useStore()
    const { posts } = storeToRefs(store)
    return {
      // you can return the whole store instance to use it in the template
      posts,
    }
  },
}

</script>