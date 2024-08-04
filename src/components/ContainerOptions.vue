<template>
  <span class="category_options">
    <ul>
      <li v-for="eachCategory in avaliableWindows" :key="eachCategory">
        <button :style="buttonStyle(eachCategory)"class="btn_category" @click="changeWindowActive(eachCategory)">{{ eachCategory }}</button>
      </li>
    </ul>
  </span>

  <PackagesCategory v-if="currentWindowActive == 'packages'" />
  <DotfilesCategory v-if="currentWindowActive == 'dotfiles'" />
</template>

<script setup lang="ts">
import { ref } from 'vue';
import PackagesCategory from './PackagesCategory.vue';
import DotfilesCategory from './DotfilesCategory.vue';

const avaliableWindows = ['dotfiles', 'packages']
const currentWindowActive = ref('dotfiles')

const errorExists = ref(false)
const errorMessage = ref('')

const changeWindowActive = (windowName: string) => avaliableWindows.includes(windowName) ? currentWindowActive.value = windowName : currentWindowActive.value = 'dotfiles';
const buttonStyle = (category: string) => ({ backgroundColor: currentWindowActive.value === category ? '#1e2030' : 'transparent' });
</script>

<style>
.category_options ul {
  display: flex;
  align-items: center;
  justify-content: start;
}
.btn_category {
  padding: 1em 2em;
  background-color: transparent;
  border: none;
  border-radius: 8px 8px 0px 0px;
  cursor: pointer;
  transition: 300ms ease-in-out;
  text-transform: capitalize;
}
.btn_category:hover {
  color: #cad3f5;
}
</style>