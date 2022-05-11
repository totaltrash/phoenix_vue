<template>
  <H1>Stores</H1>
  <DataTable :items="posts" :cols="cols"></DataTable>
</template>

<script setup>
import { useStore } from '~/stores/store'
import { storeToRefs } from 'pinia'
import H1 from '~/components/heading/H1.vue'
import DataTable from '~/components/DataTable.vue'

const store = useStore()
const { posts } = storeToRefs(store)
const cols = [
  { field: "id", label: "#", class: "w-32" },
  { field: "title", label: "Title" },
]
</script>
