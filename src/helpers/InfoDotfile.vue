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
  <HandleErrorMessage v-if="show_error" :message="msg_error"/>
</template>

<script setup lang="ts">
import { invoke } from '@tauri-apps/api';
import { ref, defineProps, defineEmits } from 'vue';
import HandleErrorMessage from './HandleErrorMessage.vue';

const emit = defineEmits(['close']);

const props = defineProps<{ name: string }>()
const completedInstallation = ref(false);
const installing = ref(false);
const show_error = ref(false);
const msg_error = ref('');

const handle_close = () => emit('close');
const install_dotfiles = async () => {
  installing.value = true;
  try {
    const result = await invoke('execute_script', { scriptName: props.name });
    console.log('Script output:', result);
    completedInstallation.value = true;
  } catch (error) {
    show_error.value = true;
    msg_error.value = error as string;
  } finally {
    installing.value = false;
  };
};
</script>