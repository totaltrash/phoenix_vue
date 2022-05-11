<template>
  <H1>Home</H1>

  <H2>Data</H2>
  <DataTable v-if="data" :cols="cols" :items="data.listCourses.results" class="mb-4" />
  <!-- <div>
    {{ data }}
  </div> -->

  <H2>Fetching</H2>
  {{ fetching }}

  <H2>Error</H2>
  {{ error }}

</template>

<script setup>
import { useQuery } from '@urql/vue'
import { H1, H2 } from '~/components/heading'
import DataTable from '~/components/DataTable.vue'

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
})

const { fetching, data, error } = result

const cols = [
  { field: "code", label: "Code", class: "w-64" },
  { field: "title", label: "Title" },
]

// const fetching = result.fetching
// const data = result.data
// const error = result.error

// const page = reactive({ page: data.listCourses })
// const items = result?.data?.listCourses?.results ?? []

// const items = computed(() => {
//   return result.data ? result.data.listCourses.results : []
//   // return result?.data?.listCourses?.results ?? []
//   // if (result.data) {
//   //   return JSON.parse(result.data.listCourses.results);
//   // } else {
//   //   return []
//   // }
// })

// console.log(result.data.listCourses)
// if (result.data && result.data.listCourses) {
//   return result.data.listCourses.results
// }

// return [{ id: 666, title: 'GRR' }]
// })

</script>
