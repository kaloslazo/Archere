<template>
    <div class="modal-overlay" @click="handle_close">
    <div class="info-wrapper" @click.stop>
      <h3>{{ props.name }} dotfile</h3>
      <hr />
      <pre class="pre-wrapper" v-if="dotfile_script_code">{{ dotfile_script_code }}</pre>
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
import { ref, defineProps, defineEmits, onMounted } from 'vue';
import HandleErrorMessage from './HandleErrorMessage.vue';

const emit = defineEmits(['close']);

const props = defineProps<{ name: string }>()
const completedInstallation = ref(false);
const installing = ref(false);
const show_error = ref(false);
const dotfile_script_code = ref('');
const msg_error = ref('');

const handle_close = () => emit('close');
const load_script_content = async () => {
  try {
    const content = await invoke('read_script_contents', { scriptName: props.name });
    dotfile_script_code.value = content as string;
  } catch (error) {
    console.error('Failed loading script content', error);
    msg_error.value = error as string;
    show_error.value = true;
  }
};
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

onMounted(load_script_content);
</script>