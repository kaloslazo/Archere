<script setup lang="ts">
import { defineProps, ref } from 'vue';

const props = defineProps<{ message: string }>()
const isErrorActive = ref(true);

const handleErrorMsg = () => isErrorActive.value = false;
</script>

<template>
  <div class="error_container" v-if="isErrorActive">
    <span class="error_title">
      <h3>Error</h3>
      <button class="cross_btn" @click="handleErrorMsg()">X</button>
    </span>
    <p>{{ props.message || 'Error message' }}</p>
  </div>
</template>