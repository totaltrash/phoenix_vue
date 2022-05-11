<template>
  <h1 data-role="header-title" class="text-3xl font-bold mb-8">
    <slot>{{ content }}</slot>
  </h1>
</template>

<script setup>
const props = defineProps({
  content: {
    type: String
  }
})
</script>
