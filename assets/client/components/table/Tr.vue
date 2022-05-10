<template>
  <tr :class="class">
    <slot />
  </tr>
</template>

<script setup>
const props = defineProps({
  class: {
    type: String
  }
})
</script>
