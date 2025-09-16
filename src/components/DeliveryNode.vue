<template>
  <div class=".vue-flow__node-custom">


    <!-- <v-avatar color="black">
      <v-icon icon="mdi-account"></v-icon>
    </v-avatar>
    {{ data.label }} -->
    <div><v-avatar><v-icon icon="mdi-monitor" size="large"></v-icon></v-avatar>{{ data.label }}</div>

    <!-- <div>
      {{ x }} {{ y }}
    </div> -->

    <Handle type="source" :position="Position.Top" />
    <Handle type="target" :position="Position.Bottom" />
  </div>
</template>

<script setup>
import { computed } from 'vue'
import { Position, Handle } from '@vue-flow/core'

const props = defineProps({
  id: {
    type: String,
    required: true,
  },
  position: {
    type: Object,
    required: true,
  },
  data: {
    type: Object,
    required: true,
  },
})


const x = computed(() => `${Math.round(props.position.x)}px`)
const y = computed(() => `${Math.round(props.position.y)}px`)
</script>

<style scoped>
.vue-flow__node-custom {
    background: #9CA8B3;
    color: #fff;
    padding: 10px;
}
</style>