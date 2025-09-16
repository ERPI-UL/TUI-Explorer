<script lang="ts" setup>
defineProps<{ label: string }>()
</script>

<template>
  <div><v-avatar><v-icon icon="mdi-account" size="large"></v-icon></v-avatar> {{ label }}</div>
</template>