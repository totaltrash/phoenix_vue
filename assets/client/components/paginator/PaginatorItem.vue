<template>
  <a v-if="enabled && !selected" href="#" :class="itemClass" @click="$emit('click', page)">
    <component v-if="icon" :is="icon" class="h-4 w-4"></component>
    <span v-else>{{ page }}</span>
  </a>
  <span v-else :class="itemClass" :data-role="itemRole">
    <component v-if="icon" :is="icon" class="h-4 w-4"></component>
    <span v-else>{{ page }}</span>
  </span>
</template>

<script setup>
import { computed } from 'vue'
const props = defineProps({
  page: {
    type: Number,
    required: false,
  },
  enabled: {
    type: Boolean,
    default: true
  },
  selected: {
    type: Boolean,
    default: false
  },
  hideOnMobile: {
    type: Boolean,
    default: false
  },
  icon: {}
})
const itemClass = computed(() => {
  return {
    "items-center justify-center w-9 text-sm font-medium border": true,
    "hidden sm:inline-flex": props.hideOnMobile,
    "inline-flex": !props.hideOnMobile,
    "border-sky-700 text-white bg-sky-700": props.selected,
    "border-gray-300 bg-white": !props.selected,
    "text-gray-700 hover:bg-gray-100": !props.selected && props.enabled,
    "text-gray-400": !props.selected && !props.enabled,
  }
})
const itemRole = computed(() => props.selected ? "selected-page" : null)

defineEmits(['click'])

</script>