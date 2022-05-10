<template>
  <td class="px-4 sm:px-6 py-4 whitespace-nowrap align-top" :class="class" :colspan="colspan">
    <slot>{{ content }}</slot>
  </td>
</template>

<script setup>
const props = defineProps({
  colspan: {
    type: String
  },
  class: {
    type: String
  },
  content: {
    type: String
  }
})
</script>
