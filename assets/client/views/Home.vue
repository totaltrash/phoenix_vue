<template>
  <h1 data-role="header-title" class="text-3xl font-bold">Home</h1>
</template>

<script setup>
import { ref, onMounted } from 'vue'

// const el = ref()
import { createClient } from 'graphql-ws';

onMounted(() => {
  // el.value // <div>
  console.log('here')

  const client = createClient({
    url: 'ws://localhost:4000/api/graphql-ws',
  });

  // query
  (async () => {
    const result = await new Promise((resolve, reject) => {
      let result;
      client.subscribe(
        {
          query: '{ listCourses {id fullTitle code title} }',
        },
        {
          next: (data) => (result = data),
          error: reject,
          complete: () => resolve(result),
        },
      );
    });

    console.log(result)
    // expect(result).toEqual({ hello: 'Hello World!' });
  })();
})
</script>