<template>
  <Table :class="class">
    <Thead>
      <Tr>
        <Th v-for="col in cols" :class="col.class">
          {{ col.label }}
        </Th>
      </Tr>
    </Thead>
    <Tbody>
      <Tr v-if="items.length == 0">
        <Td :colspan="cols.length" class="italic">
          {{ emptyMessage || 'None' }}
        </Td>
      </Tr>
      <Tr v-else v-for="item in items">
        <Td v-for="col in cols">
          <slot :name="col.field" v-bind="item">
            {{ item[col.field] }}
          </slot>
        </Td>
      </Tr>
    </Tbody>
  </Table>
</template>

<script setup>
import { Table, Thead, Tbody, Tr, Td, Th } from '~/components/table'
const props = defineProps({
  items: {
    type: Array,
    required: true,
  },
  cols: {
    type: Array,
    required: true,
  },
  class: {
    type: String
  },
  emptyMessage: {
    type: String
  },
})
</script>
