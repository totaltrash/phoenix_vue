<template>
  <H1>Home</H1>

  <div v-if="data">
    <H2>Courses</H2>
    <DataTable :cols="cols" :items="data.listCourses.results" class="mb-4" />
    <Paginator @change="(newOffset) => offset = newOffset" :count="data.listCourses.count" :offset="offset"
      :limit="limit" />
  </div>

  <div v-if="fetching">
    <div class="text-gray-600">
      loading...
    </div>
  </div>

  <div v-if="error">
    <H2>Error</H2>
    {{ error }}
  </div>
</template>

<script setup>
import { ref, reactive } from 'vue'
import { useQuery } from '@urql/vue'
import { H1, H2 } from '~/components/heading'
import DataTable from '~/components/DataTable.vue'
import Paginator from '~/components/Paginator.vue'

const offset = ref(0)
const limit = 10

const result = useQuery({
  query: `query ($limit: Int!, $offset: Int!) { listCourses(limit: $limit, offset: $offset) {
    count
    results {
      id
      code
      title
    }
  } }`,
  variables: { limit, offset }
})

const { fetching, data, error } = result

const cols = [
  { field: "code", label: "Code", class: "w-64" },
  { field: "title", label: "Title" },
]

</script>
