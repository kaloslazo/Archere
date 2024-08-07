<template>
  <div class="packages_container">
    <ul class="container-category">
      <li v-for="eachCategory in categories" :key="eachCategory.name">
        <button class="btn-category"
                :style="{
                  '--btn-border-color': eachCategory.color,
                  '--btn-text-color': eachCategory.color,
                  '--btn-bg-color': `${eachCategory.color}20`
                }" 
                :aria-label="`Category: ${eachCategory.name}`"
                @click="showCategoryInfo(eachCategory)">
          <span :style="{padding: '0em 1em'}">{{ eachCategory.nerd_icon }}</span>
          <span>{{ eachCategory.name }}</span>
        </button>
      </li>
    </ul>
    
    <!-- Categories info -->
    <InfoPackage 
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
import InfoPackage from '../helpers/InfoPackage.vue'

export default {
  components: {
    InfoPackage
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
          nerd_icon: info.nerd_icon,
          color: info.color, 
          packages: info.packages
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
.packages_container {
  background-color: #1e2030;
  border-radius: 0px 0px 8px 8px;
  padding: 1em 0em;
  min-height: 160px;
  max-height: 160px;
}
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
