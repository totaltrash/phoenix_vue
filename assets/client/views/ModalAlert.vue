<template>
  <Alert heading="Alert Modal" :open="show" @ok="close">
    Something happened!
  </Alert>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import Alert from '~/components/modal/Alert.vue'

const show = ref(false)
const router = useRouter()

onMounted(() => show.value = true)

function close() {
  show.value = false
  setTimeout(() => { router.push('/modals') }, 200)
}
</script>
