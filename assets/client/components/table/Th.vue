<template>
  <th class="px-4 sm:px-6 py-3 text-left text-sm font-medium text-gray-600" :class="class" :colspan="colspan">
    <slot>{{ content }}</slot>
  </th>
</template>

<script setup>
const props = defineProps({
  colspan: {
    type: Number
  },
  class: {
    type: String
  },
  content: {
    type: String
  }
})
</script>
