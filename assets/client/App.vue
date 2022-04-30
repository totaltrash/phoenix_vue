<script setup>
import Navbar from './components/Navbar.vue';
</script>

<template>
  <div class="md:container md:mx-auto">
    <Navbar />
    <div class="py-8 px-4">
      <router-view></router-view>
    </div>
  </div>
</template>
