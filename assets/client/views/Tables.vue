<template>
  <H1>Tables</H1>
  <H2>Simple Table</H2>
  <Table class="border-gray-200 shadow-lg mb-12">
    <Thead>
      <Tr>
        <Th class="w-[280px]" content="Test" />
        <Th>Another</Th>
      </Tr>
    </Thead>
    <Tbody>
      <Tr>
        <Td content="Some Inline Content!" />
        <Td>More Content!</Td>
      </Tr>
      <Tr>
        <Td>Some Content!</Td>
        <Td class="bg-green-700 text-white">Green Content!</Td>
      </Tr>
      <Tr>
        <Td :colspan="2" class="bg-gray-50">
          2 Column Content... 2 Column Content... 2 Column Content... 2 Column Content... 2 Column
          Content... 2 Column Content... 2 Column Content... !
        </Td>
      </Tr>
      <Tr class="bg-red-700 text-white">
        <Td>Some Content!</Td>
        <Td>More Content!</Td>
      </Tr>
    </Tbody>
  </Table>

  <H2>Data Table</H2>
  <DataTable :items="items" :cols="cols" class="mb-12" />

  <H2>Data Table - Custom Content Slots</H2>
  <DataTable :items="items" :cols="cols" class="mb-12">
    <template #title="item">
      <em>{{ item.title }}</em>
    </template>
  </DataTable>

  <H2>Data Table - Empty</H2>
  <DataTable empty-message="No items found" :items="[]" :cols="cols" class="mb-12" />
</template>

<script setup>
import { Table, Thead, Tbody, Tr, Td, Th } from '~/components/table'
import { H1, H2 } from '~/components/heading'
import DataTable from '~/components/DataTable.vue'
const items = [
  { id: 123, title: "Some Content!" },
  { id: 456, title: "More Content!" }
]
const cols = [
  { field: "id", label: "#", class: "w-32" },
  { field: "title", label: "Title" },
]
</script>
