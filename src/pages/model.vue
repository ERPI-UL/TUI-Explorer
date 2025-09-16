<template>
    <v-toolbar density="compact">
            <v-spacer></v-spacer>
            <v-btn icon="mdi-sort"></v-btn>
            <v-btn icon="mdi-filter"></v-btn>
        </v-toolbar>
    <v-container class="fill-height">
        
        <VueFlow :nodes="nodes" :edges="edges" :nodes-draggable="false"  >
            <template #node-special="specialNodeProps">
                <SpecialNode v-bind="specialNodeProps" />
            </template>
            <template #node-delivery="deliveryNodeProps">
                <DeliveryNode v-bind="deliveryNodeProps"/>
            </template>
            <!-- <Panel>
            <button type="button" @click="addNode">Add a node</button>
        </Panel> -->
            <Background pattern-color="#aaa" :gap="16" />

        </VueFlow>
    </v-container>

</template>

<script setup>
import { ref, onMounted } from 'vue'
import { VueFlow, Panel, MarkerType, Position } from '@vue-flow/core'
import { Background } from '@vue-flow/background'
import SpecialNode from '@/components/SpecialNode.vue'
import DeliveryNode from '@/components/DeliveryNode.vue'


const nodes = ref([
    {
        id: 'user',
        type: 'special',
        position: { x: 0, y: -100 },
        data: { label: 'User', },
    },
    {
        id: 'TUI',
        position: { x: 150, y: 0 },
        //data: { label: 'Interface', },
        style: { backgroundColor: 'rgba(16, 185, 129, 0.5)', width: '350px', height: '160px' },
    },
    {
        id: "interface",
        position: { x: 100, y: 30 },
        data: { label: "Interface" },
        extent: 'parent',
        parentNode: 'TUI',
        // expandParent: true,
    },
    {
        id: "actuator",
        position: { x: 10, y: 90 },
        data: { label: "Actuator" },
        extent: 'parent',
        parentNode: 'TUI',
        // expandParent: true,
    },
    {
        id: "sensor",
        position: { x: 190, y: 90 },
        data: { label: "Sensor" },
        extent: 'parent',
        parentNode: 'TUI',
        // expandParent: true,
    },
    {
        id: 'backend',
        type: 'output',
        position: { x: 0, y: 250 },
        data: { label: 'Back end technologies', },
    },
    {
        id: 'delivery',
        type: 'delivery',
        position: { x: -100, y: 50 },
        data: { label: 'Delivery technologies', },
        style: { backgroundColor: 'rgba(255, 255, 255, 1)', padding: '10px',  borderRadius: '3px',  fontSize: '12px',  textAlign: 'center',  borderWidth: '1px', width: '200px', height: '60px', borderWidth: '1px',
  borderStyle: 'solid'},
    }
]);

const edges = ref([
    { id: 'e-user-interface', label: "Input type", source: 'user', target: 'TUI', markerEnd: MarkerType.Arrow, },
    // { id: 'e-actuator-3', label: "Data", source: 'actuator', target: 'backend' },
    { id: 'e-actuator-user', label: "Output type", source: 'actuator', target: 'user' },
    { id: 'e3-4', label: "Data", source: 'backend', target: 'delivery' },
    { id: 'e3-2-3', label: "Data", source: 'TUI', target: 'backend' },
    // { id: 'e3-2-3', label: "Data", source: 'backend', target: 'TUI' },
    { id: 'e4-user', label: "Output type", source: 'delivery', target: 'user' },
]);

// function addNode() {
//     const id = Date.now().toString()

//     nodes.value.push({
//         id,
//         position: { x: 150, y: 50 },
//         data: { label: `Node ${id}`, },
//     })
// }
</script>

<style>
/* these are necessary styles for vue flow */
@import '@vue-flow/core/dist/style.css';

/* this contains the default theme, these are optional styles */
@import '@vue-flow/core/dist/theme-default.css';
</style>