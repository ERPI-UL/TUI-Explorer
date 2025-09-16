<template>
  <v-app>
    <!-- Navbar -->
    <NavBar :showButton="showButton" />
    <!-- <v-app-bar theme="dark">

      <template v-slot:prepend>
        <v-app-bar-nav-icon @click.stop="drawer = !drawer"></v-app-bar-nav-icon>
      </template>

      <v-app-bar-title>TUI Explorer</v-app-bar-title>
      <v-btn icon="mdi-filter" variant="text" @click.stop="filterPanel = !filterPanel"></v-btn>
    </v-app-bar>
    <v-navigation-drawer v-model="drawer">
      <v-list nav>
        <v-list-item title="Tool" key="tool" nav router link to="/list" ></v-list-item>
        <v-list-item title="About" key="about" nav router link to="/about"></v-list-item>
      </v-list>
    </v-navigation-drawer> -->
    <v-main>
      <router-view />
    </v-main>
  </v-app>
</template>

<script setup>
import { useRoute, useRouter } from 'vue-router'
import { ref, computed, watch} from 'vue';
import NavBar from '@/components/NavBar.vue';
//
// const router = useRouter()
const route = useRoute()

const showButton = computed(() => route.path === '/list');

</script>
