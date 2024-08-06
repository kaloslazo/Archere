<template>
    <div class="modal-overlay" @click="handle_close">
    <div class="info-wrapper" @click.stop>
      <h3>{{ props.name }} dotfile</h3>
      <hr />
      <div class="modal-btns">
        <button class="modal-btn modal-close" @click="handle_close" :disabled="installing">Close</button>
        <button class="modal-btn modal-install" @click="install_dotfiles" :disabled="installing || completedInstallation">
          {{ completedInstallation ? 'Installed.' : (installing ? 'Installing...' : 'Install') }}
        </button>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, defineProps, defineEmits } from 'vue';

const emit = defineEmits(['close']);

const props = defineProps<{ name: string }>()
const completedInstallation = ref(false);
const installing = ref(false);

const install_dotfiles = () => {}
const handle_close = () => emit('close');
</script>