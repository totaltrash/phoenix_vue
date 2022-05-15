<template>
  <Modal :heading="heading" :icon="BellIcon" :open="open" @close="$emit('close')">
    <slot></slot>
    <template #buttons>
      <ModalButton label=" OK" @click="$emit('ok')" color="primary" />
      <ModalButton label="Cancel" @click="$emit('cancel')" />
    </template>
  </Modal>
</template>

<script setup>
import Modal from '~/components/modal/Modal.vue'
import ModalButton from '~/components/modal/ModalButton.vue'
import { BellIcon } from '@heroicons/vue/outline'
defineProps(['heading', 'open'])
defineEmits(['ok', 'cancel', 'close'])
</script>
