<template>
  <h1 data-role="header-title" class="text-3xl font-bold mb-8">Tables</h1>
  <Table class="border-gray-200 rounded shadow-lg">
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
        <Td colspan="2" class="bg-gray-50">
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
</template>

<script setup>
import { Table, Thead, Tbody, Tr, Td, Th } from '~/components/table'
</script>
