<template>
  <h1 data-role="header-title" class="text-3xl font-bold">Home</h1>
  <h2 class="text-xl font-bold">Data</h2>
  {{ data }}
  <h2 class="text-xl font-bold">Fetching</h2>
  {{ fetching }}
  <h2 class="text-xl font-bold">Error</h2>
  {{ error }}
</template>

<script>
import { useQuery } from '@urql/vue'

export default {
  setup() {
    const result = useQuery({
      query: `{ listCourses(limit: 1) {
        count
        results {
          id
          fullTitle
          code
          title
        }
      } }`
    });

    return {
      fetching: result.fetching,
      data: result.data,
      error: result.error,
    };
  }
}
</script>
