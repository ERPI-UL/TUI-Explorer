<template>
  <v-app-bar app theme="dark">

    <v-app-bar-nav-icon @click.stop="drawer = !drawer" v-if="smAndDown"></v-app-bar-nav-icon>
    <v-app-bar-title>TUI Explorer</v-app-bar-title>

    <div v-if="mdAndUp">
      <v-btn nav router link to="/list">Gallery</v-btn>
      <v-btn nav router link to="/vizualisation">Viz</v-btn>
      <!-- <v-btn nav router link to="/model">TUI design</v-btn> -->
      <v-btn nav router link to="/about">About</v-btn>
    </div>

    <v-spacer></v-spacer>
    <v-btn href="https://forms.gle/jryFskSuW2kPkhDj8">New entry</v-btn>
  </v-app-bar>
  <v-navigation-drawer v-model="drawer" app temporary>
    <v-list-item link to="/list" title="Gallery" nav router key="Gallery">
    </v-list-item>
    <v-list-item link to="/vizualisation" title="Viz" nav router key="Viz">
    </v-list-item>
    <v-list-item link to="/about" title="About" nav router key="About">
    </v-list-item>
  </v-navigation-drawer>
  <!-- <v-navigation-drawer v-model="drawer">
      <v-list nav>
        <v-list-item title="Tool" key="tool" nav router link to="/list" ></v-list-item>
        <v-list-item title="About" key="about" nav router link to="/about"></v-list-item>
      </v-list>
    </v-navigation-drawer> -->
</template>

<script setup>
import { defineProps, ref, watch } from 'vue';
import { useDisplay } from 'vuetify'

// Destructure only the keys you want to use
const { smAndDown, mdAndUp } = useDisplay()

// Define props
const props = defineProps({
  showButton: Boolean,
});

const drawer = ref(false)
const group = ref(null)

watch(group, () => {
  drawer.value = false

})
</script>
