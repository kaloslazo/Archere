<template>
  <div>
    <!-- categories options -->
    <ul class="container-category">
      <li v-for="eachCategory in categories" :key="eachCategory.name">
        <button class="btn-category" 
                :style="{ borderColor: eachCategory.color, color: eachCategory.color }" 
                :aria-label="`Category: ${eachCategory.name}`"
                @click="showCategoryInfo(eachCategory)">
          {{ eachCategory.name }}
        </button>
      </li>
    </ul>
    
    <!-- Categories info -->
    <InfoCategory 
      v-if="selectedCategory" 
      :category="selectedCategory.name" 
      :categoryColor="selectedCategory.color"
      :packageList="selectedCategory.packages" 
       @close="selectedCategory = null"
    />
  </div>
</template>

<script>
import packagesData from '../data/packages.json';
import InfoCategory from './InfoCategory.vue';

export default {
  components: {
    InfoCategory
  },
  data() {
    return {
      packages: packagesData,
      selectedCategory: null
    };
  },
  computed: {
    categories() {
      return Object.entries(this.packages.categories).map(([name, info]) => {
        return { 
          name, 
          color: info.color, 
          packages: info.packages // Asegúrate de que esta clave exista en tu JSON
        };
      });
    }
  },
  methods: {
    showCategoryInfo(category) {
      this.selectedCategory = category;
    }
  }
}
</script>

<style>
.container-category {
  margin: 0 auto;
  min-width: 768px;
  max-width: 768px;
  display: grid;
  justify-items: center;
  align-items: center;
  grid-template-columns: repeat(3, 1fr);
  grid-template-rows: repeat(2, 1fr);
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
}
.btn-category:hover {
  background-color: #363a4f;
}
</style>
