<template>
  <H1>Modals</H1>
  <div class="flex gap-2">
    <button @click="modalOpen = true" class="rounded bg-gray-100 hover:bg-gray-200 py-3 px-4">Open Modal</button>
    <button @click="alertOpen = true" class="rounded bg-gray-100 hover:bg-gray-200 py-3 px-4">Open Alert</button>
    <button @click="confirmOpen = true" class="rounded bg-gray-100 hover:bg-gray-200 py-3 px-4">Open Confirm</button>
    <router-link to="/modals/alert" class="rounded bg-gray-100 hover:bg-gray-200 py-3 px-4">
      Alert via Route
    </router-link>
  </div>
  <Modal :open="modalOpen" @close="modalOpen = false" heading="Base Modal" :icon="SearchIcon"
    icon-color="bg-red-100 text-red-600">
    Hello Modal
    <template #buttons>
      <ModalButton label="Deactivate" @click="deactivateClicked()" color="danger" />
      <ModalButton label="Cancel" @click="modalOpen = false" />
    </template>
  </Modal>

  <Alert heading="Alert Modal" :open="alertOpen" @ok="alertOpen = false">
    Something happened!
  </Alert>

  <Confirm heading="Confirm Modal" :open="confirmOpen" @ok="confirmOpen = false" @cancel="confirmOpen = false">
    Something happened!
  </Confirm>

  <router-view></router-view>
</template>

<script setup>
import { ref } from 'vue'
import { H1, H2 } from '~/components/heading'
import Modal from '~/components/modal/Modal.vue'
import Alert from '~/components/modal/Alert.vue'
import Confirm from '~/components/modal/Confirm.vue'
import ModalButton from '~/components/modal/ModalButton.vue'
import { SearchIcon, PencilIcon, TrashIcon } from '@heroicons/vue/solid'

const modalOpen = ref(false)
const alertOpen = ref(false)
const confirmOpen = ref(false)
const formOpen = ref(false)

function deactivateClicked() {
  console.log('deactivate clicked...')
  modalOpen.value = false
}
</script>
