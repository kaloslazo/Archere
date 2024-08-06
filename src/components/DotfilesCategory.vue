<template>
  <div class="dotfiles_container">
    <ul class="container-category">
      <li v-for="script in dotfilesScripts" :key="script.name">
        <button class="btn-category" 
                :style="{
                  '--btn-border-color': script.color,
                  '--btn-text-color': script.color,
                  '--btn-bg-color': `${script.color}20`
                }" 
                :aria-label="`Script: ${script.name}`"
                @click="show_dotfiles_category(script.name)">
          <span :style="{ padding: '0em 1em' }">{{ script.nerd_icon }}</span>
          <span>{{ script.name }}</span>
        </button>
      </li>
    </ul>
  </div>
  <InfoDotfile v-if="selected_dotfile !== ''" :name="selected_dotfile" @close="selected_dotfile = ''"/>
</template>

<script setup lang="ts">
import { computed, ref } from 'vue';
import dotfilesData from '../data/dotfiles.json';
import InfoDotfile from '../helpers/InfoDotfile.vue';

const dotfiles = ref(dotfilesData.scripts);
const selected_dotfile = ref<string>('');

const show_dotfiles_category = (script_dotfile: any) => selected_dotfile.value = script_dotfile;
const dotfilesScripts = computed(() => dotfiles.value);
</script>

<style>
.dotfiles_container {
  background-color: #1e2030;
  border-radius: 0px 0px 8px 8px;
  padding: 1em 0em;
  min-height: 160px;
}
.btn-category {
  margin: 0.5em auto;
  width: 225px;
  height: 50px;
  cursor: pointer;
  border-radius: 12px;
  background-color: transparent;
  border: 2px solid var(--btn-border-color);
  color: var(--btn-text-color);
  transition: background-color 0.2s ease-in-out, border-color 0.2s ease-in-out, color 0.2s ease-in-out;
  text-transform: capitalize;
  display: flex;
  align-items: center;
  justify-content: center;
}

.btn-category:hover {
  background-color: var(--btn-bg-color);
  border-color: var(--btn-border-color);
}
</style>