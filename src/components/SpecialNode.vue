<template>
    <div class="vue-flow__node-default">

        <div><v-avatar><v-icon icon="mdi-account" size="large"></v-icon></v-avatar>{{ data.label }}</div>

        <Handle type="target" :position="Position.Bottom" />
        <Handle type="source" :position="Position.Left" />
        <Handle type="target" :position="Position.Right" />
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