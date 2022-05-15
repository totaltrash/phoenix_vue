<template>
  <button :type="type" @click="$emit('click')"
    class="w-full inline-flex justify-center rounded-md border shadow-sm px-4 py-2 text-base font-medium focus:outline-none focus:ring-2 focus:ring-offset-2 sm:w-auto sm:text-sm"
    :class="colorClass">
    {{ label }}
  </button>
</template>

<script setup>
import { computed } from 'vue'

const props = defineProps({
  label: { type: String, required: true },
  type: { type: String, default: 'button' },
  color: { type: String, default: 'modal_default' },
})

defineEmits(['click'])

const colorClass = computed(() => {
  switch (props.color) {
    case 'primary':
      return 'bg-sky-600 hover:bg-sky-700 text-white border-transparent focus:ring-sky-500'
    case 'danger':
      return 'bg-red-600 hover:bg-red-700 text-white border-transparent focus:ring-red-500'
    case 'modal_default':
      return 'bg-white hover:bg-gray-50 text-gray-700 border-gray-300 focus:ring-gray-300'
  }
})
</script>