<template>
  <div class="dotfiles_container">
    <ul class="container-category">
      <li v-for="script in dotfilesScripts" :key="script.name">
        <button class="btn-category" 
                :style="{ borderColor: script.color, color: script.color }" 
                :aria-label="`Script: ${script}`"
                @click="showDotfilesCategory(script)">
          <span :style="{padding: '0em 1em'}">{{ script.nerd_icon }}</span>
          <span>{{ script.name }}</span>
        </button>
      </li>
    </ul>
  </div>
</template>

<script setup lang="ts">
import { computed, ref } from 'vue';
import dotfilesData from '../data/dotfiles.json';

const dotfiles = ref(dotfilesData.scripts);
const selectedDotfile = ref(null);

const showDotfilesCategory = (scriptDotfile: any) => selectedDotfile.value = scriptDotfile;
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
  border: 2px solid transparent;
  transition: background-color 0.2s ease-in-out, border-color 0.2s ease-in-out;
  text-transform: capitalize;
  display: flex;
  align-items: center;
  justify-content: center;
}
.btn-category:hover {
  background-color: #363a4f;
}
</style>