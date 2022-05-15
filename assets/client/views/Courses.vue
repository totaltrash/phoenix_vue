<template>
  <H1>Courses</H1>

  <div v-if="data">
    <DataTable :cols="cols" :items="data.listCourses.results" class="mb-4">
      <template #actions="item">
        <div class="flex gap-1 items-center">
          <router-link :to="'/courses/' + item.id"
            class="rounded bg-gray-100 text-purple-700 hover:bg-purple-700 hover:text-white p-1">
            <SearchIcon class="h-4 w-4" />
          </router-link>
          <button class="rounded bg-gray-100 text-cyan-700 hover:bg-cyan-700 hover:text-white p-1">
            <PencilIcon class="h-4 w-4" />
          </button>
          <button @click="deleteCourse(item.id)"
            class="rounded bg-gray-100 text-red-700 hover:bg-red-700 hover:text-white p-1">
            <TrashIcon class="h-4 w-4" />
          </button>
        </div>
      </template>
    </DataTable>
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

  <router-view></router-view>
</template>

<script setup>
import { ref, reactive } from 'vue'
import { useQuery, useMutation } from '@urql/vue'
import { H1, H2 } from '~/components/heading'
import DataTable from '~/components/DataTable.vue'
import Paginator from '~/components/Paginator.vue'
import { SearchIcon, PencilIcon, TrashIcon } from '@heroicons/vue/solid'

const offset = ref(0)
const limit = 10

const { fetching, data, error, executeQuery } = useQuery({
  query: `query ($limit: Int!, $offset: Int!) { listCourses(limit: $limit, offset: $offset) {
    count
    results { id code title }
  } }`,
  variables: { limit, offset }
})

const { executeMutation: deleteCourseMutation } = useMutation(`
  mutation ($id: ID!) {
    destroyCourse(id: $id) {
      errors { code fields message shortMessage }
      result { id code title }
    }
  }
`)

const cols = [
  { field: "actions", label: "", class: "w-16" },
  { field: "code", label: "Code", class: "w-48" },
  { field: "title", label: "Title" },
]

function deleteCourse(id) {
  deleteCourseMutation({ id }).then(result => {
    refreshList()
  })
}

function refreshList() {
  executeQuery({
    requestPolicy: 'network-only',
  })
}

</script>
