<template>
  <div :class="class">
    <div class="-my-2 overflow-x-auto sm:-mx-6 lg:-mx-8">
      <div class="py-2 align-middle inline-block min-w-full sm:px-6 lg:px-8">
        <div class="overflow-hidden border-b border-gray-100">
          <table class="min-w-full">
            <slot />
          </table>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
const props = defineProps(['class'])
</script>
