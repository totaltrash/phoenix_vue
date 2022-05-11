<template>
  <h2 class="text-xl font-bold my-2">
    <slot>{{ content }}</slot>
  </h2>
</template>

<script setup>
const props = defineProps({
  content: {
    type: String
  }
})
</script>
