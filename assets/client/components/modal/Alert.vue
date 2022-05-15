<template>
  <Modal :heading="heading" :icon="BellIcon" :open="open" @close="$emit('close')" @closed="$emit('closed')">
    <slot></slot>
    <template #buttons>
      <ModalButton label="OK" @click="$emit('ok')" color="primary" />
    </template>
  </Modal>
</template>

<script setup>
import Modal from '~/components/modal/Modal.vue'
import ModalButton from '~/components/modal/ModalButton.vue'
import { BellIcon } from '@heroicons/vue/outline'
defineProps(['heading', 'open'])
defineEmits(['ok', 'close', 'closed'])
</script>
