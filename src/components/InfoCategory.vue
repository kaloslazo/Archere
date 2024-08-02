<script setup lang="ts">
import { ref, onMounted, onUnmounted } from 'vue';
import { defineProps, defineEmits } from 'vue';
import { invoke } from '@tauri-apps/api/tauri';
import { listen } from '@tauri-apps/api/event';

const props = defineProps<{ category: string, categoryColor: string, packageList: { name: string }[] }>()
const emit = defineEmits(['close']);

const installing = ref(false);
const completedInstallation = ref(false);
const installedPackages = ref(new Set<string>());
const errors = ref(new Set<string>());

onMounted(() => {
  const storedPackages = localStorage.getItem('installedPackages');
  if (storedPackages) {
    const parsedPackages = JSON.parse(storedPackages);
    parsedPackages.forEach((pkg: string) => installedPackages.value.add(pkg));
    checkCompletedInstallation();
  }

  const unlistenedInstalled = listen('package-installed', (event) => {
    markAsInstalled(event.payload as string);
  });
  const unlistenedError = listen('package-error', (event) => {
    markAsError(event.payload as string);
  });

  return () => {
    unlistenedInstalled.then((unlisten) => unlisten());
    unlistenedError.then((unlisten) => unlisten());
  };
});

// >> handler for package installation via tauri
const installPackages = async () => {
  installing.value = true;

  try {
    await invoke('install_packages', { packages: props.packageList.map((pkg) => pkg.name) });
  } catch (error) {
    console.error("Error installing packages:", error);
  } finally {
    installing.value = false;
    checkCompletedInstallation();
  }
};

// >> helpers
const markAsInstalled = (pkgName: string) => {
  installedPackages.value.add(pkgName);
  saveInstalledPackages();
  checkCompletedInstallation();
};

const markAsError = (pkgName: string) => errors.value.add(pkgName);

const checkCompletedInstallation = () => {
  completedInstallation.value = props.packageList.every(eachPkg => installedPackages.value.has(eachPkg.name));
}

const saveInstalledPackages = () => {
  const installedArray = Array.from(installedPackages.value);
  localStorage.setItem('installedPackages', JSON.stringify(installedArray));
};

const handleClose = () => {
  saveInstalledPackages();
  emit('close');
};
</script>

<template>
  <div class="modal-overlay" @click="handleClose">
    <div class="info-wrapper" @click.stop>
      <h3>{{ props.category }} packages</h3>
      <hr />
      <ul class="pkg-container">
        <li class="pkg-info" v-for="eachPackage in props.packageList" :key="eachPackage.name">
          <p :style="{ fontStyle: installedPackages.has(eachPackage.name) ? 'italic' : 'normal', color: installedPackages.has(eachPackage.name) ? '#a6da95' : '#cad3f5', textDecoration: installedPackages.has(eachPackage.name) ? 'line-through' : 'none' }">
            {{ eachPackage.name }}
            <span v-if="installedPackages.has(eachPackage.name)">✅</span>
          </p>
        </li>
      </ul>
      <div class="modal-btns">
        <button class="modal-btn modal-close" @click="handleClose" :disabled="installing">Close</button>
        <button class="modal-btn modal-install" @click="installPackages" :disabled="installing || completedInstallation">
          {{ completedInstallation ? 'Installed.' : (installing ? 'Installing...' : 'Install') }}
        </button>
      </div>
    </div>
  </div>
</template>

<style>
.error-message {
  color: red;
  margin-top: 1em;
}
hr {
  margin-top: 1em;
  height: 0.5px;
  color: #363a4f;
  border: 1px solid #363a4f;
}
.modal-overlay {
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background-color: #18192690;
  display: flex;
  align-items: center;
  align-items: center;
  z-index: 10000;
}
.info-wrapper {
  position: absolute;
  padding: 4em 2em;
  width: 100%;
  max-width: 500px;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  background-color: #24273a;
  border: 2px solid #363a4f;
  border-radius: 8px;
}
.info-wrapper h3 {
  font-size: 1.5em;
}
.pkg-container {
  padding: 2em 0em;
  display: grid;
  justify-items: start;
  align-items: center;
  grid-template-columns: repeat(2, 1fr);
  column-gap: 1em;
  row-gap: 0.5em;
}
.pkg-info {
  width: 100%;
  font-size: 1em;
  padding: 0.5em 0.5em;
  border-radius: 4px;
  background: #363a4f;
}
.modal-btns {
  display: flex;
  flex-direction: row;
  gap: 1em;
  font-size: 0.9em;
}
.modal-btn {
  padding: 0.5em 0em;
  width: 100px;
  border-radius: 4px;
  border: 1px solid transparent;
  color: #24273a;
  font-weight: 500;
  text-transform: capitalize;
  cursor: pointer;
  transition: 300ms ease-in-out;
}
.modal-close {
  background-color: #ed8796;
}
.modal-close:hover {
  background-color: #ed8796b9;
}
.modal-install {
  background-color: #8aadf4;
}
.modal-install:hover {
  background-color: #8aadf4b9;
}
</style>
